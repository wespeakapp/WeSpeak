//
//  Review.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class Review: NSObject, NSCoding {
    var partner: String!
    var photoPartner: String!
    var comment: String!
    var stats: Stats!
    var gift: Gift!
    var rating: Double!
    
    override init() {
        super.init()
        
        partner = ""
        photoPartner = "man"
        comment = ""
        stats = Stats()
        gift = Gift()
        rating = 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(partner, forKey: "partner")
        aCoder.encode(photoPartner, forKey: "photoPartner")
        aCoder.encode(comment, forKey: "comment")
        aCoder.encode(stats, forKey: "stats")
        aCoder.encode(gift, forKey: "gift")
        aCoder.encode(rating, forKey: "rating")
    }
    
    required init?(coder aDecoder: NSCoder) {
        partner = aDecoder.decodeObject(forKey: "partner") as! String
        photoPartner = aDecoder.decodeObject(forKey: "photoPartner") as! String
        comment = aDecoder.decodeObject(forKey: "comment") as! String
        stats = aDecoder.decodeObject(forKey: "stats") as! Stats
        gift = aDecoder.decodeObject(forKey: "gift") as! Gift
        rating = aDecoder.decodeObject(forKey: "rating") as! Double
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if let partner = dictionary["partner"] as? String {
            self.partner = partner
        } else {
            partner = ""
        }
        
        if let photo = dictionary["photo_partner"] as? String {
            self.photoPartner = photo
        } else {
            photoPartner = ""
        }
        
        if let comment = dictionary["comment"] as? String {
            self.comment = comment
        } else {
            comment = ""
        }
        
        if let statsDictionary = dictionary["stats"] as? NSDictionary {
            self.stats = Stats(dictionary: statsDictionary)
        } else {
            stats = Stats()
        }
        
        if let giftDictionary = dictionary["gift"] as? NSDictionary {
            self.gift = Gift(dictionary: giftDictionary)
        } else {
            gift = Gift()
        }
        
        if let rating = dictionary["rating"] as? Double {
            self.rating = rating
        } else {
            rating = 0
        }
    }
    
//    func initReview(){
//        stats = Stats()
//        gift = Gift()
//    }
    
//    func initReview(dictionary: NSDictionary) {
//        initReview()
//        
//        if let partner = dictionary["partner"] as? String {
//            self.partner = partner
//        }
//        
//        if let comment = dictionary["comment"] as? String {
//            self.comment = comment
//        }
//        
//        if let statsDictionary = dictionary["stats"] as? NSDictionary {
//            self.stats?.initStats(dictionary: statsDictionary)
//        }
//        
//        if let giftDictionary = dictionary["gift"] as? NSDictionary {
//            self.gift?.initGift(dictionary: giftDictionary)
//        }
//        
//        if let rating = dictionary["rating"] as? Double {
//            self.rating = rating
//        }
//    }
    
    func dictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict.updateValue(partner as AnyObject, forKey: "partner")
        dict.updateValue(photoPartner as AnyObject, forKey: "photo_partner")
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
    
    class func arrayDictionary(reviews: [Review]) -> [[String: AnyObject]] {
        var array = [[String: AnyObject]]()
        for review in reviews {
            array.append(review.dictionary())
        }
        
        return array
    }
}
