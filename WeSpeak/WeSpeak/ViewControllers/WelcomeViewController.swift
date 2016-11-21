//
//  WelcomeViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/15/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var teachButton: UIButton!
    @IBOutlet weak var learnButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        visualEffectView.isHidden = true
    }

    func setButton(){
        teachButton.layer.cornerRadius = 6
        learnButton.layer.cornerRadius = 6
    }
    
    @IBAction func onTeachButton(_ sender: AnyObject) {
        let email = "gabi@gmail.com"
        let password = "1"
        saveSpeakerInfo(email , password: password, type: "speaker")
        User.current.type = UserType.speaker
        User.current.email = email
        User.current.password = password
        User.current.profilePhoto = "gabi"
        User.current.name = "Gabi Diamond"
        Singleton.sharedInstance.partner.type = UserType.learner
        
        FireBaseClient.shared.signIn(email: "datlt@magik.vn", password: "123456789", completion: {(user, error) in
            if let userId = user?.uid {
                User.current.uid = userId
            }
            User.current.type = UserType.speaker
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Singleton.getTabbar()
        })
        
//        try! realm.write {
//            realm.add(User.current)
//        }
        
    }
    
    //var namePopup:LeanerSignIn
    @IBAction func onLearnButton(_ sender: AnyObject) {
        //performSegue(withIdentifier: SegueIdentifier.SegueMatch, sender: self)
        
        //            let namePopup = LearnerSignIn(frame: CGRect(x: 16, y: 200, width: 220, height: 205))
        //            self.view.addSubview(namePopup)
        //            visualEffectView.isHidden = false
        let name = "Huy Ngo"
        saveLearnerInfo(name, type: "learner")
        
        User.current.initUser()
        User.current.review?.initReview()
        User.current.type = UserType.learner
        User.current.name = name
        Singleton.sharedInstance.partner.type = UserType.speaker
        FireBaseClient.shared.signIn(email: "datlt.uit@gmail.com", password: "123456789", completion: {(user, error) in
            if let userId = user?.uid {
                User.current.uid = userId
            }
            User.current.type = UserType.learner
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = Singleton.getTabbar()
        })
        
//        try! realm.write {
//            realm.add(User.current)
//        }
        
        
        
    }
    
    func saveLearnerInfo(_ name:String, type:String){
        UserDefaults.standard.set(type, forKey:"type")
        //UserDefaults.standard.set(name, forKey: "name")
    }
    
    func saveSpeakerInfo(_ email:String, password:String, type:String){
        UserDefaults.standard.set(type, forKey:"type")
        //UserDefaults.standard.set(email, forKey: "email")
        //UserDefaults.standard.set(password, forKey: "password")
    }
}
