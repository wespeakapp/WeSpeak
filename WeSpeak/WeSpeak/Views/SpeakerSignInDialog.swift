//
//  SpeakerSignInDialog.swift
//  WeSpeak
//
//  Created by Girge on 11/22/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class SpeakerSignInDialog: UIView {
    @IBOutlet weak var wraperDialog: UIView!
    @IBOutlet weak var panelDialog: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    weak var delegate: SignInDialogDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "SpeakerSignInDialog", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        panelDialog.layer.cornerRadius = 6
        panelDialog.layer.shadowColor = UIColor.black.cgColor
        panelDialog.layer.shadowOpacity = 1
        panelDialog.layer.shadowOffset = CGSize.zero
        panelDialog.layer.shadowRadius = 5
        
        okButton.layer.cornerRadius = 6
        closeButton.layer.cornerRadius = closeButton.frame.height / 2
        
        emailTextField.text = "datlt@magik.vn"
        passwordTextField.text = "123456789"
        
        showAnimation()
    }
    
    func showAnimation() {
        alpha = 0
        wraperDialog.transform = CGAffineTransform(scaleX: 3, y: 3)
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: [], animations: {
            self.wraperDialog.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
    }
    
    @IBAction func onTouchOKButton(_ sender: UIButton) {
        delegate.signInDialog(speakerDialog: self, email: emailTextField.text, password: passwordTextField.text)
    }
    @IBAction func onTouchCloseButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
}
