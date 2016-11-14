//
//  FireBaseClient.swift
//  WeSpeak
//
//  Created by Girge on 11/8/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import Firebase


class FireBaseClient {
    static var shared: FireBaseClient!
    var dataReference: FIRDatabaseReference!
    
    class func configure() {
        FIRApp.configure()
        shared = FireBaseClient()
    }
    
    init() {
        dataReference = FIRDatabase.database().reference()
    }
    
    func signIn(completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            completion(user, error)
        })
    }
    
    func signIn(email: String, password: String, completion: @escaping (FIRUser?, Error?) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            completion(user, error)
        })
    }
    
}
