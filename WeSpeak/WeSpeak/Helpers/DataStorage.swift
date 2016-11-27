//
//  DataStorage.swift
//  WeSpeak
//
//  Created by Girge on 11/26/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation

class DataStorage {
    static let key = "user_archived"
    static var userDefaults = UserDefaults.standard
    
    class func saveUser() {
        let data = NSKeyedArchiver.archivedData(withRootObject: User.current)
        userDefaults.set(data, forKey: key)
        userDefaults.synchronize()
    }
    
    class func loadUser() -> Bool {
        let data = userDefaults.object(forKey: key) as? Data
        print("defaults: \(data)")
        if let user = data {
            User.current = NSKeyedUnarchiver.unarchiveObject(with: user) as! User
            return true
        }
        
        return false
    }
}
