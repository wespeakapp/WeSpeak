//
//  QuestionCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import Cosmos

class QuestionCell: UITableViewCell {


    @IBOutlet weak var ratingControl: CosmosView!
    @IBOutlet weak var questionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ratingControl.didFinishTouchingCosmos = valueChanged
    
        // Configure the view for the selected state
    }
    
    func valueChanged(value:Double){
        Singleton.sharedInstance.partner.review.rating = value
    }

}
