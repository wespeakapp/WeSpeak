//
//  ItemCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var conversationsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var user:User?{
        didSet{
            hoursLabel.text = "\(round(user!.totalHours))"
            conversationsLabel.text = "\(user!.conversations)"
            //beersLabel.text = "\(user?.review?.gift?.beer)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }

}
