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
        let dialog = SpeakerSignInDialog()
        dialog.delegate = self
        dialog.frame = view.bounds
        view.addSubview(dialog)
    }
    
    //var namePopup:LeanerSignIn
    @IBAction func onLearnButton(_ sender: AnyObject) {
        let dialog = LearnerSignInDialog()
        dialog.delegate = self
        dialog.frame = view.bounds
        dialog.viewController = self
        view.addSubview(dialog)
    }
    
    func saveUserInfo(type:String){
        UserDefaults.standard.set(type, forKey:"type")
        //UserDefaults.standard.set(name, forKey: "name")
    }
}

extension WelcomeViewController: SignInDialogDelegate {
    func signInDialog(learnerDialog: UIView, name: String?) {
        if let name = name, !name.isEmpty {
            ProgressHUD.show(view: view)
            
            User.current.name = name
            
            FireBaseClient.shared.signIn(completion: { (user, error) in
                if let user = user {
                    User.current.type = UserType.learner
                    User.current.uid = user.uid
//                    self.saveUserInfo(type: "learner")
                    Singleton.sharedInstance.partner.type = UserType.speaker
                    
                    FireBaseClient.shared.loadUserData(completion: { (exist) in
                        if !exist {
                            FireBaseClient.shared.saveUserData()
                        }
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = Singleton.getTabbar()
                    })
                }
            })
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func signInDialog(speakerDialog: UIView, email: String?, password: String?) {
        if let email = email, let password = password, !email.isEmpty, !password.isEmpty {
            ProgressHUD.show(view: view)
            
            FireBaseClient.shared.signIn(email: email, password: password, completion: {(user, error) in
                if user != nil {
//                    User.current.type = UserType.speaker
//                    User.current.email = email
//                    User.current.password = password
//                    User.current.profilePhoto = "gabi"
//                    User.current.name = "Gabi Diamond"
                    Singleton.sharedInstance.partner.type = UserType.learner
                    DataStorage.saveUser()
                    
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = Singleton.getTabbar()
                } else {
                    let alert = UIAlertController(title: "Error", message: "Invalid email or password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })

        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
