//
//  User.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

enum UserType {
    case learner
    case speaker
}

class User {
    static var current: User = User()
    var uid: String?
    var type: UserType?
    var name: String?
    var email: String?
    var password: String?
//    var birthDay: Date?
//    var country: String?
    var _photoUrl: URL?
    var conversation: Int?
    var totalHours: Double?
    var stats: Stats?
    var reviews: [Review]?
}
