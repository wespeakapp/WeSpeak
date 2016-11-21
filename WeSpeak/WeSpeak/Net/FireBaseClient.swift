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
    
    func signIn(completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            completion(user, error)
        })
    }
    
    func signIn(email: String, password: String, completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            completion(user, error)
        })
    }
    
    func signUp(email: String, password: String, completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            completion(user, error)
        })
    }
    
    func onSpeakerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        handleLearnerAvailable(completion: completion)
    }
    
    func onLearnerMatch(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").child(User.current.uid).setValue(true)
        dataReference.child("available/learners").child(User.current.uid).observeSingleEvent(of: .childAdded, with: { (snapshot) in
            if let sessionId = snapshot.value as? String {
                self.dataReference.child("sessions/\(sessionId)/token").observeSingleEvent(of: .value, with: { (snapshot) in
                    if let token = snapshot.value as? String {
                        completion(sessionId, token)
                    }
                })
                self.dataReference.child("available/learners").child(User.current.uid).setValue(nil)
            }
        })
    }
    
    func handleLearnerAvailable(completion: @escaping (_ session: String, _ token: String) -> Void) {
        dataReference.child("available/learners").observeSingleEvent(of: .value, with: {snapshot in
            if let learners = snapshot.value as? NSDictionary {
                self.createSession(learnerId: learners.allKeys[0] as! String, completion: completion)
            } else {
                self.handleLearnerAvailable(completion: completion)
            }
        })
    }
    
    func createSession(learnerId: String, completion: @escaping (_ session: String, _ token: String) -> Void) {
        HerokuClient.shared.getSession { (dictionary, error) in
            if let dictionary = dictionary {
                let sessionId = dictionary["session"]!
                let token = dictionary["token"]!
                self.dataReference.child("available/learners").child(learnerId).updateChildValues(["session_id" : sessionId])
                self.dataReference.child("sessions").child(sessionId).updateChildValues(["token": token])
                completion(sessionId, token)
            }
        }
    }
    
    func commitReview(sessionId: String, review: Review, completion: @escaping (_ session: String, _ token: String) -> Void) {
        let dictionaryReview = review.dictionary()
        
        let typeUser = User.current.isSpeaker ? "learner" : "speaker"
        
        dataReference.child("sessions/\(sessionId)/\(typeUser)/rating").setValue(dictionaryReview)
    }
    
    func handleReview(sessionId: String, completion: @escaping (_ review: Review?) -> Void) {
        let typeUser = User.current.isSpeaker ? "speaker" : "learner"
        
        dataReference.child("sessions/\(sessionId)/\(typeUser)").observeSingleEvent(of: .childAdded, with: {snapshot in
            if let reviewDictionary = snapshot.value as? NSDictionary {
                let review = Review()
                review.initReview(dictionary: reviewDictionary)
                
                completion(review)
            } else {
                completion(nil)
            }
        })
    }
}
