//
//  FireBaseClient.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import Firebase

class FireBaseClient {
    static var shared: FireBaseClient!
    var dataReference: FIRDatabaseReference!
    
    class func configure() {
        FIRApp.configure()
        shared = FireBaseClient()
    }
    
    init() {
        dataReference = FIRDatabase.database().reference()
    }
    
    func saveUserData() {
        let data = NSKeyedArchiver.archivedData(withRootObject: User.current)
        let stringData = data.base64EncodedString()
        
        DataStorage.saveUser()
        dataReference.child("data/\(User.current.uid!)").setValue(stringData)
    }
    
    func loadUserData(completion: @escaping (Bool) -> Void) {
        dataReference.child("data/\(User.current.uid!)").observeSingleEvent(of: .value, with: {(snapshot) in
            if let dataString = snapshot.value as? String, let data = NSData(base64Encoded: dataString, options: []) {
                User.current = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! User
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    func loadUserSpeaker(completion: @escaping (Bool) -> Void) {
        loadUserData(completion: {(exist) in
            if !exist {
                completion(false)
            } else {
                self.dataReference.child("speakers/\(User.current.uid!)").observeSingleEvent(of: .value, with: {(snapshot) in
                    if let dictionary = snapshot.value as? NSDictionary {
                        
                        User.current.name = dictionary["name"] as! String
                        User.current.profilePhoto = dictionary["photo"] as! String
                        print(User.current.profilePhoto)
                        completion(true)
                    }
                })
            }
        })
    }
    
    func signIn(completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            if let user = user {
                self.dataReference.child("learners/\(user.uid)").observeSingleEvent(of: .value, with: { snapshot in
                    if let value = snapshot.value as? NSObject, value is NSNull {
                        self.dataReference.child("learners/\(user.uid)").updateChildValues(["name": User.current.name])
                    }
                })
            }
            completion(user, error)
        })
    }
    
    func signIn(email: String, password: String, completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                User.current.uid = user.uid
                User.current.type = UserType.speaker
                User.current.email = email
                User.current.password = password
                self.loadUserSpeaker(completion: { (exist) in
                    if !exist {
                        self.saveUserData()
                    }
                })
                completion(user, error)
            } else {
                completion(user, error)
            }
        })
    }
    
    func signUp(email: String, password: String, completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                self.dataReference.child("speakers/\(user.uid)").updateChildValues(["name": User.current.name])
            }
            completion(user, error)
        })
    }
    
    func onSpeakerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        handleLearnerAvailable(completion: completion)
    }
    
    func onLearnerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        let learnerInfo = ["uid": User.current.uid,
                           "name": User.current.name,
                           "photo": User.current.profilePhoto,
                           "rating": User.current.learnerAverageRating(),
                           "matched": false] as [String : Any]
        dataReference.child("available/learners/\(User.current.uid!)").updateChildValues(learnerInfo)
        handleSpeakerAvailable(completion: completion)
    }
    
    func handleSpeakerAvailable(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").child(User.current.uid).observeSingleEvent(of: .childChanged, with: { (snapshot) in
            if let sessionId = snapshot.value as? String {
                self.dataReference.child("sessions/\(sessionId)").observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? NSDictionary {
                        Singleton.sharedInstance.partner.uid = dictionary["speakerUid"] as! String
                        Singleton.sharedInstance.partner.name = dictionary["speakerName"] as! String
                        Singleton.sharedInstance.partner.rating = dictionary["speakerRating"] as! Double
                        Singleton.sharedInstance.partner.profilePhoto = dictionary["speakerPhoto"] as! String
                        Singleton.sharedInstance.partner.type = UserType.speaker
                        Singleton.sharedInstance.sessionIdOpenTok = sessionId
                        completion(sessionId, dictionary["token"] as! String)
                    }
                })
                self.dataReference.child("available/learners/\(User.current.uid!)").setValue(nil)
            }
            
        })
    }
    
    func removeHandleSpeakerAvailable() {
        dataReference.child("available/learners").child(User.current.uid).removeAllObservers()
        dataReference.child("available/learners").child(User.current.uid).setValue(nil)
    }
    
    func handleLearnerAvailable(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").observeSingleEvent(of: .value, with: {snapshot in
            if let learners = snapshot.value as? NSDictionary {
                if let learnerInfo = learners[learners.allKeys[0]] as? NSDictionary {
                    Singleton.sharedInstance.partner.name = learnerInfo["name"] as! String
                    Singleton.sharedInstance.partner.rating = learnerInfo["rating"] as! Double
                    Singleton.sharedInstance.partner.uid = learnerInfo["uid"] as! String
                    Singleton.sharedInstance.partner.profilePhoto = learnerInfo["photo"] as! String
                    Singleton.sharedInstance.partner.type = UserType.learner
                    self.createSession(completion: completion)
                }
            } else {
                self.handleLearnerAvailable(completion: completion)
            }
        })
    }
    
    func removeHandleLearnerAvailable() {
        dataReference.child("available/learners").removeAllObservers()
    }
    
    func createSession(completion: @escaping (_ session: String, _ token: String) -> Void) {
//        dataReference.child("learners/\(Singleton.sharedInstance.partner.uid!)/name").observeSingleEvent(of: .value, with: {snapshot in
//            Singleton.sharedInstance.partner.name = snapshot.value as! String
//        })
        
        HerokuClient.shared.getSession { (dictionary, error) in
            if let dictionary = dictionary {
                let sessionId = dictionary["session"]!
                Singleton.sharedInstance.sessionIdOpenTok = sessionId
                let token = dictionary["token"]!
                let dictionary = ["session_id" : sessionId,
                                  "token": token,
                                  "learnerUid": Singleton.sharedInstance.partner.uid,
                                  "learnerName": Singleton.sharedInstance.partner.name,
                                  "learnerRating": Singleton.sharedInstance.partner.rating,
                                  "speakerUid": User.current.uid,
                                  "speakerName": User.current.name,
                                  "speakerRating": User.current.speakerAverageRatings(),
                                  "speakerPhoto": User.current.profilePhoto] as [String : Any]
                self.dataReference.child("sessions/\(sessionId)").updateChildValues(dictionary)
                self.dataReference.child("available/learners/\(Singleton.sharedInstance.partner.uid!)").updateChildValues(["matched": sessionId])
                completion(sessionId, token)
            }
        }
    }
    
    func commitReview(review: Review) {
        let dictionaryReview = review.dictionary()
        
        dataReference.child("rating/\(Singleton.sharedInstance.partner.uid!)/\(Singleton.sharedInstance.sessionIdOpenTok!)").setValue(dictionaryReview)
    }
    
    func loadReviews(completion: @escaping (_ reviews: [Review]?) -> Void) {
        dataReference.child("rating/\(User.current.uid!)").observeSingleEvent(of: .value, with: {snapshot in
            print(User.current.uid)
            self.dataReference.child("rating/\(User.current.uid!)").setValue(nil)
            if let reviewsDictionary = snapshot.value as? NSDictionary {
                var reviews = [Review]()
                for index in 0 ..< reviewsDictionary.count {
                    let review = Review(dictionary: reviewsDictionary[reviewsDictionary.allKeys[index]] as! NSDictionary)
                    reviews.append(review)
                }
                completion(reviews)
                self.saveUserData()
            } else {
                completion(nil)
            }
        })
    }
}
