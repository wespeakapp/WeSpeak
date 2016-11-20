//
//  User.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit
import RealmSwift

enum UserType {
    case learner
    case speaker
}

class User: Object {
    static var current: User = User()
    dynamic var uid: String = ""
    var type: UserType?
    dynamic var name: String = ""
    dynamic var email: String = ""
    dynamic var password: String = ""
    //var _photoUrl: URL?
    dynamic var profilePhoto:String = "huy"
    dynamic var conversations: Int = 0
    dynamic var totalHours: Double = 0
    dynamic var review:Review? 
    var reviews = List<Review>()
    
    var isSpeaker: Bool {
        get{
            return type == UserType.speaker
        }
    }
    
    func initUser(){
       review = Review()
    }
}
