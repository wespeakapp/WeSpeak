//
//  Review.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class Review: NSObject {
    var speakerName: String?
    var comment: String?
    var stats: Stats
    var gift: Gift
    var rating:Double
    
    override init() {
        stats = Stats()
        gift = Gift()
        rating = 0
    }
    
}
