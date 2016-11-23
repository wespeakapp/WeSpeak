//
//  MatchViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/15/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift

class MatchViewController: UIViewController {
    @IBOutlet weak var matchButton: UIButton!
    @IBOutlet weak var matchButtonBgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var blurView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup match button
//        matchButton.layer.borderWidth = 3
//        matchButton.layer.borderColor = #colorLiteral(red: 0, green: 0.6823529412, blue: 0.6431372549, alpha: 1).cgColor
        matchButton.layer.cornerRadius = matchButton.frame.height / 2
//        matchButtonBgImageView.layer.cornerRadius = matchButtonBgImageView.frame.height / 2
        // set title
        if !User.current.isSpeaker {
            titleLabel.text = WSString.matchViewLearnerTitle
        } else {
            titleLabel.text = WSString.matchViewSpeakerTitle
        }
    }
    
    func loadDB(){
        let user_type = UserDefaults.standard.string(forKey: Keys.type)
        if user_type != nil{
            let objects = try! realm.objects(User.self)
            if objects.count > 0{
                User.current = objects.first!
                try! realm.write {
                    User.current.review = Review()
                }
                if user_type == "learner"{
                    User.current.type = UserType.learner
                    
                }
                else{
                    User.current.type = UserType.speaker
                }
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var matched = false
    @IBAction func onMatchButton(_ sender: UIButton) {
        if !matched {
            Singleton.fakeData()
            matched = true
            
//            let dialog = SpeakerSignInDialog()
//            dialog.frame = view.bounds
//            view.addSubview(dialog)
            
            matchButtonBgImageView.image = #imageLiteral(resourceName: "findingBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: { 
                self.blurView.alpha = 1
                self.titleLabel.textColor = #colorLiteral(red: 0.4950980392, green: 0.5, blue: 0.5, alpha: 1)
                
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: (self.tabBarController?.tabBar.frame.height)!)
                
            }, completion: nil)
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = CGFloat(M_PI * 2.0)
            animation.duration = 1
            animation.repeatCount = Float.infinity
            matchButtonBgImageView.layer.add(animation, forKey: "rotate")
            
            matchButton.setTitle("Finding...", for: .normal)
            
            if User.current.isSpeaker {
                FireBaseClient.shared.onSpeakerMatch(completion: {(session, token) in
                    self.sessionId = session
                    self.token = token
                    self.performSegue(withIdentifier: SegueIdentifier.SegueCall, sender: nil)
                })
            } else {
                FireBaseClient.shared.onLearnerMatch(completion: { (session, token) in
                    print(session)
                    print(token)
                    self.sessionId = session
                    self.token = token
                    self.performSegue(withIdentifier: SegueIdentifier.SegueCall, sender: nil)
                })
            }
        } else {
            matched = false
            matchButtonBgImageView.image = #imageLiteral(resourceName: "findBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.blurView.alpha = 0
                self.titleLabel.textColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
                self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: (self.tabBarController?.tabBar.frame.origin.x)!, y: 0)
            }, completion: nil)
            
            matchButton.setTitle("Find", for: .normal)
        }
    }
    
    var sessionId: String!
    var token: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.SegueCall {
            let callViewController = segue.destination as! CallViewController
            callViewController.sessionId = sessionId
            callViewController.token = token
        }
    }
}
