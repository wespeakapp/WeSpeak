//
//  LeanerSignIn.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/16/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class LearnerSignIn: UIView {


    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var nameTextField: UITextField!
   
    @IBAction func onOkButton(_ sender: Any) {
    }


    @IBAction func onCancelButton(_ sender: Any) {
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubview()
    }
    
    func initSubview(){
        //backgroundView.layer.cornerRadius = 6
        let nib = UINib(nibName: "LearnerSignIn", bundle: nil)
        let object = nib.instantiate(withOwner: self , options: nil)
        let view = object.last as! UIView
        contentView.frame = bounds
        backgroundView.layer.cornerRadius = 6
        addSubview(view)
        
    }

}
