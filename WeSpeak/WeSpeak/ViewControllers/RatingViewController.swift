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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNib()
        NotificationCenter.default.addObserver(self, selector: #selector(RatingViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RatingViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
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
    
    func keyboardWillShow(notification: NSNotification) {
        /*bottomConstraint.constant = 250
         UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
         }*/
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height/1.2
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        /*bottomConstraint.constant = 149
         UIView.animate(withDuration: 0.3) {
         self.view.layoutIfNeeded()
         }*/
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height/1.2
            }
        }
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
        
        let type:UserType = (Singleton.sharedInstance.partner.type)!
        switch type {
        case .speaker:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
                cell.nameLabel.text = Singleton.sharedInstance.partner.name
                 cell.profileImageView.image = UIImage(named: Singleton.sharedInstance.partner.profilePhoto)
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
        case .learner:
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
                cell.nameLabel.text = Singleton.sharedInstance.partner.name
                cell.profileImageView.image = UIImage(named: Singleton.sharedInstance.partner.profilePhoto)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell") as! QuestionCell
                cell.questionLabel.text = Singleton.skills[indexPath.row]

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
                return 100
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
        //FireBaseClient.shared.commitReview(sessionId: Singleton.sharedInstance.sessionIdOpenTok, review: Singleton.sharedInstance.partner.review!)
        
        if(User.current.type == UserType.learner){
            let review = Review()
            review.partner = "Gabi Diamond"
            review.comment = "He speaking english flucency but need to focus on pronounciation."
            let l = 4//arc4random_uniform(5)
            let v = 3//arc4random_uniform(5)
            let p = 3//arc4random_uniform(5)
            let f = 3//arc4random_uniform(5)
            let average = (l+v+p+f)/4
            review.rating = round(Double(average*2))/2
            review.stats = Stats(value: [l, p, f, v])
            try! realm.write {
                User.current.reviews.append(review)
                User.current.conversations += 1
            }

        }
        else{
            let review = Review()
            review.partner = "Huy Ngo"
            review.comment = "She friendly and so cute. I love her accent, hope see you!"
            let r = 4//arc4random_uniform(5)
            review.rating = Double(r)
            try! realm.write {
                User.current.reviews.append(review)
                User.current.conversations += 1
            }
            
        }
        present(Singleton.getTabbar(), animated: true, completion: nil)
    }

}
