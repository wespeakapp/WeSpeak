//
//  ProgressHUD.swift
//  WeSpeak
//
//  Created by Girge on 11/25/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressHUD: MBProgressHUD {
    class func show(view: UIView) {
        showAdded(to: view, animated: true)
    }
    
    class func hide(view: UIView) {
        hide(for: view, animated: true)
    }
}
