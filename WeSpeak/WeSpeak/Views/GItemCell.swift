//
//  GItemCell.swift
//  WeSpeak
//
//  Created by Girge on 11/29/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class GItemCell: UITableViewCell {

    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var conversationsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var user:User?{
        didSet{
//            hoursLabel.text = "\(round(user!.totalHours + 2.3))"
            hoursLabel.text = "\(0.4)"
            conversationsLabel.text = "\(user!.conversations!)"
            //beersLabel.text = "\(user?.review?.gift?.beer)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wrapperView.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8784313725, blue: 0.8509803922, alpha: 1).cgColor
        wrapperView.layer.borderWidth = 0.5
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
