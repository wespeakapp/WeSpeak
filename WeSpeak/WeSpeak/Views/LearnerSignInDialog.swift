//
//  LearnerSignInDialog.swift
//  WeSpeak
//
//  Created by Girge on 11/22/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

@objc protocol SignInDialogDelegate {
    func signInDialog(learnerDialog: UIView, name: String?)
    
    func signInDialog(speakerDialog: UIView, email: String?, password: String?)
}

class LearnerSignInDialog: UIView {
    @IBOutlet weak var wraperDialog: UIView!
    @IBOutlet weak var panelDialog: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    weak var delegate: SignInDialogDelegate!
    
    var viewController: WelcomeViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "LearnerSignInDialog", bundle: nil)
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
        
        photoView.layer.cornerRadius = photoView.frame.height / 2
        
        showAnimation()
        User.current.profilePhoto = "man"
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
        delegate.signInDialog(learnerDialog: self, name: nameTextField.text)
    }
    
    @IBAction func onTouchCloseButton(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func onTouchPhotoButton(_ sender: UIButton) {
        let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PickPhotoViewController") as! PickPhotoViewController
        nextVC.delegate = self
        viewController.present(nextVC, animated: true, completion: nil)
    }
    @IBAction func onNameEditingDidBegin(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5, animations: {
            self.wraperDialog.transform = CGAffineTransform(translationX: 0, y: -120)
        })
    }
}

extension LearnerSignInDialog: PickPhotoViewControllerDelegate {
    func pickPhoto(namePhoto: String) {
        photoView.image = UIImage(named: namePhoto)
        User.current.profilePhoto = namePhoto
    }
}
