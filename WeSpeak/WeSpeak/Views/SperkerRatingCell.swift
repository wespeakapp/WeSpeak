//
//  SperkerRatingCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import Cosmos

class SperkerRatingCell: UITableViewCell {

    @IBOutlet weak var totalRatingsLabel: UILabel!
    @IBOutlet weak var ratingControl: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingControl.settings.updateOnTouch = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
