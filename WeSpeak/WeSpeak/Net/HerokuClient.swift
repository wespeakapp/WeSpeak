//
//  HerokuClient.swift
//  WeSpeak
//
//  Created by Girge on 11/20/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import AFNetworking

struct URLServer {
    static let base = "https://englishtok.herokuapp.com"
    static let createSession = "create_session.php"
}

class SessionSponse {
    var session: String
    var token: String
    
    init(data : [String: AnyObject]) {
        session = data["session"] as! String
        token = data["token"] as! String
    }
}

class HerokuClient: AFHTTPSessionManager {
    static var shared = HerokuClient(baseURL: URL(string: URLServer.base))
    
    func getSession(complete: @escaping ([String: String]?, Error?) -> Void) {
        get(URLServer.createSession, parameters: nil, progress: nil, success: { (task, response) in
            if let dictionary = response as? [String: String] {
                complete(dictionary, nil)
            }
        }) { (task, error) in
            complete(nil, error)
        }
    }
}
