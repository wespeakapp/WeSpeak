//
//  ViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    
    @IBOutlet weak var reviewTableView: UITableView!
    let skills:[String] = ["Listening", "Pronounciation", "Fluency", "Vocabulary"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //User.current.type = UserType.speaker
        User.current.type = UserType.learner
        if User.current.type == UserType.learner{
            Singleton.sharedInstance.partner.type = UserType.speaker
        }
        else{
            Singleton.sharedInstance.partner.type = UserType.learner
        }
        
        loadNib()

        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.reloadData()
        //reviewTableView.estimatedRowHeight = 80
        //reviewTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func loadNib(){
         reviewTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        reviewTableView.register(UINib(nibName: "QuestionCell", bundle: nil), forCellReuseIdentifier: "QuestionCell")
        reviewTableView.register(UINib(nibName: "TipCell", bundle: nil), forCellReuseIdentifier: "TipCell")
        reviewTableView.register(UINib(nibName: "CommentCell", bundle: nil), forCellReuseIdentifier: "CommentCell")
        reviewTableView.register(UINib(nibName: "SubmitCell", bundle: nil), forCellReuseIdentifier: "SubmitCell")
    }
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        let type:UserType = (User.current.type)!
        switch type {
            case .learner:
                return 5
            case .speaker:
                return 4
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if User.current.type == UserType.speaker{
            if section == 1{
                return 4
            }
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type:UserType = (User.current.type)!
        switch type {
        case .learner:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TipCell") as! TipCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitCell") as! SubmitCell
                cell.submitButton.addTarget(self, action: #selector(submitTouchDown(_:)), for: .touchDown)
                return cell
            default:
                return UITableViewCell()
            }
        case .speaker:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
                cell.questionLabel.text = skills[indexPath.row]

                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SubmitCell") as! SubmitCell
                cell.submitButton.addTarget(self, action: #selector(submitTouchDown(_:)), for: .touchDown)
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0:
            return 170
        case 1:
            return 70
        case 2:
            if User.current.type == UserType.speaker{
                return 90
            }
            else{
                return 80
            }
        case 4:
            return 65
        default:
            if User.current.type == UserType.speaker{
                if indexPath.section == 3{
                    return 65
                }
            }
            return 90
        }

    }
    
    func submitTouchDown(_ sender: UIButton){
        print("touch down")
        performSegue(withIdentifier: "SegueProfile", sender: self)
    }

}
