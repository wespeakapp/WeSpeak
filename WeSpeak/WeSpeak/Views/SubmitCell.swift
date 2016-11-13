//
//  SubmitCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class SubmitCell: UITableViewCell {

    @IBOutlet weak var submitButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        setRoundedButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setRoundedButton(){
        submitButton.clipsToBounds = true
        submitButton.layer.cornerRadius = 7
    }
    @IBAction func onSubmitTouchDown(_ sender: AnyObject) {
    }
}
