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
        matchButton.layer.cornerRadius = 75
        
        // set title
        if User.current.type == UserType.learner {
            titleLabel.text = WSString.matchViewLearnerTitle
        } else {
            titleLabel.text = WSString.matchViewSpeakerTitle
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
