//
//  Stats.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift
class Stats: Object{
    dynamic var listening: Double = 0
    dynamic var pronounciation: Double = 0
    dynamic var fluency: Double = 0
    dynamic var vocabulary: Double = 0
    
    func initStats(dictionary: NSDictionary) {
        if let listening = dictionary["listening"] as? Double {
            self.listening = listening
        }
        
        if let pronounciation = dictionary["pronounciation"] as? Double {
            self.pronounciation = pronounciation
        }
        
        if let fluency = dictionary["listefluencyning"] as? Double {
            self.fluency = fluency
        }
        
        if let vocabulary = dictionary["vocabulary"] as? Double {
            self.vocabulary = vocabulary
        }
    }
    
    func dictionary() -> NSDictionary {
        return ["listening": listening, "pronounciation": pronounciation, "fluency": fluency, "vocabulary": vocabulary]
    }
}
