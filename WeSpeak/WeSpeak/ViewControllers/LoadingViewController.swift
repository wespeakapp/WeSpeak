//
//  LoadingViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/26/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var sloganLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DataStorage.loadUser() {
            if User.current.isSpeaker {
                FireBaseClient.shared.signIn(email: User.current.email, password: User.current.password, completion: { (user, error) in
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.window?.rootViewController = Singleton.getTabbar()
                    FireBaseClient.shared.handleReviews()
                })
            } else {
                FireBaseClient.shared.signIn(completion: { (user, error) in
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (timer) in
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        appDelegate.window?.rootViewController = Singleton.getTabbar()
                        FireBaseClient.shared.handleReviews()
                    })
                })
            }
        } else {
            let nextVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WelcomeViewController")
            (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController = nextVC
        }
        
        loadingIndicator.startAnimating()
        UIView.animate(withDuration: 0.5, animations: {
            self.logoLabel.transform = CGAffineTransform(translationX: 0, y: -40)
            self.sloganLabel.transform = CGAffineTransform(translationX: 0, y: -40)
        }, completion: {finished in
            UIView.animate(withDuration: 0.3, animations: { 
                self.loadingIndicator.layer.opacity = 1
            })
        })
    }
}
