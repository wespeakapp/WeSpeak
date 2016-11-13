//
//  CommentCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {


    @IBOutlet weak var commentTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        commentTextView.text = "Your comment"
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        commentTextView.layer.borderWidth = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
