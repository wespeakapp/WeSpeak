//
//  Gift.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift

class Gift: Object {
    dynamic var beer:Int = 0
    dynamic var coke:Int = 0
    
    func initGift(dictionary: NSDictionary) {
        if let beer = dictionary["beer"] as? Int {
            self.beer = beer
        }
        
        if let coke = dictionary["coke"] as? Int {
            self.coke = coke
        }
    }
    
    func dictionary() -> [String: AnyObject] {
        return ["bear": beer as AnyObject,
                "coke": coke as AnyObject]
    }
}
