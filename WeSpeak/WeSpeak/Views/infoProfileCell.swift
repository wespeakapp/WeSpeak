//
//  infoProfileCell.swift
//  WeSpeak
//
//  Created by Girge on 11/28/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class infoProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wrapperProfileImageView: UIView!
    
    var user:User?{
        didSet{
            nameLabel.text = user?.name
            user?.setUserPhotoView(view: profileImageView)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setImageCircular()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setImageCircular(){
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        wrapperProfileImageView.layer.cornerRadius = wrapperProfileImageView.frame.height / 2
//        profileImageView.layer.borderColor = UIColor.white.cgColor
//        profileImageView.layer.borderWidth = 3
//        profileImageView.layer.shadowColor = UIColor.black.cgColor
//        profileImageView.layer.shadowOpacity = 1
//        profileImageView.layer.shadowOffset = CGSize.zero
//        profileImageView.layer.shadowRadius = 5
        //profileImageView.layer.borderWidth = 1
        //profileImageView.image = UIImage(named: "display_photo")
    }
}
