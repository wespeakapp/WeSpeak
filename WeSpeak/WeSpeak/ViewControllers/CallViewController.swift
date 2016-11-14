//
//  CallViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/15/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {
    @IBOutlet weak var hangUpButton: UIButton!
    @IBOutlet weak var muteButton: UIButton!
    @IBOutlet weak var partnerNameLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    
    var countdownSecond = 600

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup hang up button
        hangUpButton.layer.cornerRadius = 22
        // setup mute button
        muteButton.layer.cornerRadius = 22
        muteButton.layer.borderColor = #colorLiteral(red: 0.6606677175, green: 0.660764873, blue: 0.6606466174, alpha: 1).cgColor
        muteButton.layer.borderWidth = 2
        // set partner's name
        partnerNameLabel.text = "Girgez"
        // set countdown
        countdownLabel.text = "10:00"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countdown()
    }
    
    func countdown() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (Timer) in
            self.countdownSecond -= 1
            let m = self.countdownSecond / 60
            let s = self.countdownSecond - 60 * m
            self.countdownLabel.text = "0\(m):" + (s > 9 ? "\(s)" : "0\(s)")
        })
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
