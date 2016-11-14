//
//  Stats.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class Stats: NSObject {
    var listening: Double
    var pronounciation: Double
    var fluency: Double
    var vocabulary: Double
    var feeling: Double?
    
    override init() {
        listening = 0
        pronounciation = 0
        fluency = 0
        vocabulary = 0
    }
}
