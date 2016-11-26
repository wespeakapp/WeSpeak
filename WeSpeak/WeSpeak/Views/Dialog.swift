//
//  Dialog.swift
//  WeSpeak
//
//  Created by Girge on 11/22/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import Cosmos

class Dialog: UIView {
    @IBOutlet weak var partnerPhoto: UIImageView!
    @IBOutlet weak var partnerName: UILabel!
    @IBOutlet weak var partnerRating: CosmosView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var wraperDialog: UIView!
    @IBOutlet weak var indicatorWaitingConnection: UIActivityIndicatorView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "Dialog", bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        addSubview(view)
        
        wraperDialog.layer.cornerRadius = 6
        wraperDialog.layer.shadowColor = UIColor.black.cgColor
        wraperDialog.layer.shadowOpacity = 1
        wraperDialog.layer.shadowOffset = CGSize.zero
        wraperDialog.layer.shadowRadius = 5
        partnerPhoto.layer.cornerRadius = partnerPhoto.frame.height / 2
        startButton.layer.cornerRadius = 6
        startButton.isHidden = true
        
        partnerName.text = Singleton.sharedInstance.partner.name
        
        indicatorWaitingConnection.startAnimating()
        
        showAnimation()
    }
    
    func showStartButton() {
        startButton.isHidden = false
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
    @IBAction func onTouchStartButton(_ sender: UIButton) {
        removeFromSuperview()
    }
    
}
