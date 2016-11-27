//
//  PickPhotoViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/28/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

@objc protocol PickPhotoViewControllerDelegate {
    func pickPhoto(namePhoto: String)
}

class PickPhotoViewController: UIViewController {

    weak var delegate: PickPhotoViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchPhoto1(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "man")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTouchPhoto2(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "boy")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTouchPhoto3(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "girl")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTouchPhoto4(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "girl1")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTouchPhoto5(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "girl2")
        dismiss(animated: true, completion: nil)
    }
    @IBAction func onTouchPhoto6(_ sender: UIButton) {
        delegate.pickPhoto(namePhoto: "girl3")
        dismiss(animated: true, completion: nil)
    }
}
