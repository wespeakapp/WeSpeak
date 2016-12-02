//
//  PlayRecordCell.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class PlayRecordCell: UITableViewCell {
    
    var fileName: String!
    var isPlaying = false
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func onRecordButtonTouch(_ sender: AnyObject) {
        print("record button")
        if isPlaying {
            Record.shared.pause()
            playButton.setBackgroundImage(#imageLiteral(resourceName: "play"), for: .normal)
            print("stop")
        } else {
            Record.shared.play(nameFile: fileName)
            playButton.setBackgroundImage(#imageLiteral(resourceName: "pause"), for: .normal)
            print("play")
        }
        
        isPlaying = !isPlaying
    }
}
