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
    var partner: User!
    var tabBarController:UITabBarController!
    var sessionIdOpenTok: String!
    
    fileprivate init(){
        partner = User()
        //createTabbar()
    }
    
    static let skills:[String] = ["Listening", "Pronounciation", "Fluency", "Vocabulary"]
    
    fileprivate func createTabbar(){
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        
        let matchVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchVC") as! MatchViewController
        
        //nowPlayingViewController.API_URL = URLs.NOWPLAYING_URL
        matchVC.tabBarItem.title = "Find"
        matchVC.tabBarItem.image = UIImage(named: "search")
        
        let historyVC = secondStoryboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryViewController
        historyVC.tabBarItem.title = "My Conversations"
        historyVC.tabBarItem.image = UIImage(named: "history")
        
        let profileVC = secondStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! GProfileViewController
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profile")
       
        
        tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as!UITabBarController
        tabBarController.viewControllers = [matchVC, historyVC, profileVC]
    }
    
    static func getTabbar() -> UITabBarController{
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondStoryboard = UIStoryboard(name: "Second", bundle: nil)
        
        let matchVC = mainStoryboard.instantiateViewController(withIdentifier: "MatchVC") as! MatchViewController
        
        //nowPlayingViewController.API_URL = URLs.NOWPLAYING_URL
        matchVC.tabBarItem.title = "Find"
        matchVC.tabBarItem.image = UIImage(named: "search")
        
        let historyVC = secondStoryboard.instantiateViewController(withIdentifier: "HistoryVC") as! HistoryViewController
        historyVC.tabBarItem.title = "My Conversations"
        historyVC.tabBarItem.image = UIImage(named: "history")
        
        let profileVC = secondStoryboard.instantiateViewController(withIdentifier: "ProfileVC") as! GProfileViewController
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(named: "profile")
        
        
        let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBar") as!UITabBarController
        tabBarController.tabBar.tintColor = UIColor(colorLiteralRed: 14/255, green: 160/255, blue: 147/255, alpha: 1)
        tabBarController.viewControllers = [matchVC, historyVC, profileVC]
        return tabBarController
    }
    
//    static func fakeData(){
//        if User.current.type == UserType.learner{
//            //User.current.review?.stats = Stats(value: [3.5, 3, 4, 3])
//            //User.current.totalHours = 120
//            //User.current.conversations = 70
//            //User.current.profilePhoto = "huy"
//            
//            Singleton.sharedInstance.partner.type = UserType.speaker
//            Singleton.sharedInstance.partner.name = "Gabi Diamond"
//            Singleton.sharedInstance.partner.profilePhoto = "gabi"
//        }
//        else{
//            //User.current.name = "Gabi Diamond"
//            //User.current.review?.rating = 3.5
//            //User.current.totalHours = 230
//            //User.current.conversations = 120
//            //User.current.profilePhoto = "gabi"
//            Singleton.sharedInstance.partner.type = UserType.learner
//            Singleton.sharedInstance.partner.name = "Huy Ngo"
//            Singleton.sharedInstance.partner.profilePhoto = "huy"
//        }
//    }
 
}
