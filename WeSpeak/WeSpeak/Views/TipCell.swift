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
    var tipCoke:Bool = false
    var tipBeer:Bool = false
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
            if !tipCoke{
                tipCoke = true
                tipBeer = false
            }
        case 1:
            if !tipBeer{
                tipBeer = true
                tipCoke = false
            }
        default:
            break
        }
        if tipCoke{
            Singleton.sharedInstance.partner.review?.gift?.coke += 1
        }
        if tipBeer{
            Singleton.sharedInstance.partner.review?.gift?.beer += 1
        }
    }
}
