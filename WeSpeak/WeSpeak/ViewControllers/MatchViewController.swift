//
//  MatchViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/15/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

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
        
        // set title
        if !User.current.isSpeaker {
            titleLabel.text = WSString.matchViewLearnerTitle
        } else {
            titleLabel.text = WSString.matchViewSpeakerTitle
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var matched = false
    @IBAction func onMatchButton(_ sender: UIButton) {
        if !matched {
            matched = true
            
            matchButtonBgImageView.image = #imageLiteral(resourceName: "findingBgButton")
            
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: { 
                self.blurView.alpha = 1
            }, completion: nil)
            
            let animation = CABasicAnimation(keyPath: "transform.rotation")
            animation.fromValue = 0
            animation.toValue = CGFloat(M_PI * 2.0)
            animation.duration = 1
            animation.repeatCount = Float.infinity
            matchButtonBgImageView.layer.add(animation, forKey: "rotate")
            
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
            }, completion: nil)
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
