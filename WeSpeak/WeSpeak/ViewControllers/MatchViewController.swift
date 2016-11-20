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
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup match button
        matchButton.layer.borderWidth = 3
        matchButton.layer.borderColor = #colorLiteral(red: 0, green: 0.681361258, blue: 0.6434084773, alpha: 1).cgColor
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
            if User.current.isSpeaker {
                FireBaseClient.shared.onSpeakerMatch(completion: {(session, token) in
                    self.sessionId = session
                    self.token = token
                    self.performSegue(withIdentifier: "CallSegue", sender: nil)
                })
            } else {
                FireBaseClient.shared.onLearnerMatch(completion: { (session, token) in
                    print(session)
                    print(token)
                    self.sessionId = session
                    self.token = token
                    self.performSegue(withIdentifier: "CallSegue", sender: nil)
                })
            }
        }
    }
    
    var sessionId: String!
    var token: String!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CallSegue" {
            let callViewController = segue.destination as! CallViewController
            callViewController.sessionId = sessionId
            callViewController.token = token
        }
    }
}
