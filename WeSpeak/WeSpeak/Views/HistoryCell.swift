//
//  HistoryCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
    @IBOutlet weak var wrapperCell: UIView!
    @IBOutlet weak var containerCell: UIView!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        profileImageView.layer.cornerRadius = 6
        wrapperCell.layer.cornerRadius = 3
//        wrapperCell.layer.borderWidth = 1
//        wrapperCell.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8784313725, blue: 0.8509803922, alpha: 1).cgColor
        containerCell.layer.cornerRadius = 3
        wrapperCell.layer.shadowColor = UIColor.black.cgColor
        wrapperCell.layer.shadowOpacity = 1
        wrapperCell.layer.shadowOffset = CGSize.zero
        wrapperCell.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
