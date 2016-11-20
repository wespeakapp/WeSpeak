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
}
