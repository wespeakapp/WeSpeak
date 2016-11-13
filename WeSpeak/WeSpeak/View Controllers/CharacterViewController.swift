//
//  CharacterViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController {
    @IBOutlet weak var learnButton: UIButton!
    @IBOutlet weak var teachButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        learnButton.layer.borderWidth = 1
        learnButton.layer.borderColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1).cgColor
        learnButton.layer.cornerRadius = 3
        teachButton.layer.borderWidth = 1
        teachButton.layer.borderColor = #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1).cgColor
        teachButton.layer.cornerRadius = 3
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
