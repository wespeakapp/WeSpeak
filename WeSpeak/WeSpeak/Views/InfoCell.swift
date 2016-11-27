//
//  InfoCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import AFNetworking

class InfoCell: UITableViewCell {


    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user:User?{
        didSet{
            nameLabel.text = user?.name
            user?.setUserPhotoView(view: profileImageView)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        //backgroundColor = UIColor(colorLiteralRed: 14/255, green: 160/255, blue: 147/255, alpha: 0.45)
        
        setImageCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setImageCircular(){
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = 50//profileImageView.frame.height/2
        //profileImageView.layer.borderWidth = 1
        //profileImageView.image = UIImage(named: "display_photo")
    }

}
