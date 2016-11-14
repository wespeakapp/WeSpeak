//
//  Singleton.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/14/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class Singleton{
    static let sharedInstance = Singleton()
    var partner:User!
    private init(){
        partner = User()
    }

}
