//
//  TipCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class TipCell: UITableViewCell {


    @IBOutlet weak var tipSegmented: UISegmentedControl!
    @IBOutlet weak var tipTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tipSegmentedChanged(_ sender: AnyObject) {
        let index = tipSegmented.selectedSegmentIndex
        print("index: \(index)")
        switch index {
        case 0:
            Singleton.sharedInstance.partner.review.gift.coke += 1
        case 1:
            Singleton.sharedInstance.partner.review.gift.beer += 1
        default:
            break
        }
    }
}
