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
    
    func initReview(dictionary: NSDictionary) {
        initReview()
        
        if let partner = dictionary["partner"] as? String {
            self.partner = partner
        }
        
        if let comment = dictionary["comment"] as? String {
            self.comment = comment
        }
        
        if let statsDictionary = dictionary["stats"] as? NSDictionary {
            self.stats?.initStats(dictionary: statsDictionary)
        }
        
        if let giftDictionary = dictionary["gift"] as? NSDictionary {
            self.gift?.initGift(dictionary: giftDictionary)
        }
        
        if let rating = dictionary["rating"] as? Double {
            self.rating = rating
        }
    }
    
    func dictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict.updateValue(partner as AnyObject, forKey: "partner")
        dict.updateValue(comment as AnyObject, forKey: "comment")
        
        if let stats = stats {
            dict.updateValue(stats.dictionary() as AnyObject, forKey: "stats")
        }
        
        if let gift = gift {
            dict.updateValue(gift.dictionary() as AnyObject, forKey: "gift")
        }
        
        dict.updateValue(rating as AnyObject, forKey: "rating")
        
        return dict
    }
}
