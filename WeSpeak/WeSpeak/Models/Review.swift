//
//  Review.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift

class Review: Object {
    dynamic var partner: String = ""
    dynamic var comment: String = ""
    dynamic var stats: Stats?
    dynamic var gift: Gift?
    dynamic var rating:Double = 0
    
    func initReview(){
        stats = Stats()
        gift = Gift()
    }
}
