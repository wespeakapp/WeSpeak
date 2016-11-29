//
//  GProfileViewController.swift
//  WeSpeak
//
//  Created by Girge on 11/29/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class GProfileViewController: UIViewController {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        FireBaseClient.shared.loadReviews { (reviews) in
            if let reviews = reviews {
                //                try! realm.write {
                for review in reviews{
                    User.current.reviews.append(review)
                    User.current.conversations = User.current.conversations + 1
                }
                self.profileTableView.reloadData()
                //                }
            }
        }
    }
    
    func loadNib(){
        profileTableView.register(UINib(nibName: "infoProfileCell", bundle: nil), forCellReuseIdentifier: "infoProfileCell")
        profileTableView.register(UINib(nibName: CellIdentifier.ItemCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.ItemCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.RatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.RatingCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.AverageRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.AverageRatingCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.QuestionCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.QuestionCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.SpeakerRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.SpeakerRatingCell)
        
    }
    
}

extension GProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let type = (User.current.type)!
        switch  type {
        case .learner:
            return 4
        case .speaker:
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1{
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0, 1:
            return 0
        case 2:
            return 30
        default:
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "STATS"
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: (header.textLabel?.font.fontName)!, size: 13)
        header.textLabel?.textColor = #colorLiteral(red: 0.2823529412, green: 0.3019607843, blue: 0.3254901961, alpha: 1)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            if User.current.type == UserType.learner{
                return 4
            }else{
                return 1
            }
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoProfileCell") as! infoProfileCell
            cell.user = User.current
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ItemCell) as! GItemCell
            cell.user = User.current
            return cell
            
        case 2:
            if User.current.type == UserType.learner{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                cell.pointsLabel.text = "\(learnerAverageRating(reviews: User.current.reviews))"
                cell.totalRatingsLabel.text = "\(User.current.conversations!)"
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                cell.pointsLabel.text = "\(speakerAverageRatings(reviews: User.current.reviews))"
                cell.totalRatingsLabel.text = "\(User.current.conversations!)"
                return cell
            }
            
        case 3:
            if User.current.type == UserType.learner{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RatingCell) as! RatingCell
                cell.skillLabel.text = Singleton.skills[indexPath.row]
                switch indexPath.row{
                case 0:
                    cell.ratingControl.rating = learnerAvarageSkill(skill: 0, reviews: User.current.reviews)
                case 1:
                    cell.ratingControl.rating = learnerAvarageSkill(skill: 1, reviews: User.current.reviews)
                case 2:
                    cell.ratingControl.rating = learnerAvarageSkill(skill: 2, reviews: User.current.reviews)
                case 3:
                    cell.ratingControl.rating = learnerAvarageSkill(skill: 3, reviews: User.current.reviews)
                default:
                    break
                }
                
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.QuestionCell) as! QuestionCell
                cell.questionLabel.isHidden = true
                cell.ratingControl.rating = speakerAverageRatings(reviews: User.current.reviews)
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 241
        case 1:
            return 69
        case 2:
            return 110
        default:
            return 40
        }
    }
    
    func speakerAverageRatings(reviews: [Review]) -> Double{
        var rating:Double = 0
        if reviews.count != 0{
            for review in reviews{
                print(review.rating)
                rating += review.rating
            }
            rating /= Double(reviews.count)
        }
        
        return round(rating*2)/2
    }
    
    func learnerAverageRating(reviews: [Review]) -> Double{
        var rating:Double = 0
        if reviews.count != 0{
            for review in reviews{
                rating += (review.stats?.listening)! + (review.stats?.pronounciation)! + (review.stats?.fluency)! + (review.stats?.vocabulary)!
            }
            rating /= Double(reviews.count*4)
            
        }
        return round(rating*2)/2
    }
    
    func learnerAvarageSkill(skill:Int, reviews: [Review])->Double{
        var rating:Double = 0
        if reviews.count != 0{
            switch skill{
            case 0:
                for review in reviews{
                    rating += (review.stats?.listening)!
                }
                rating /= Double(reviews.count)
                return round(rating*2)/2
            case 1:
                for review in reviews{
                    rating += (review.stats?.pronounciation)!
                }
                rating /= Double(reviews.count)
                return round(rating*2)/2
            case 2:
                for review in reviews{
                    rating += (review.stats?.fluency)!
                }
                rating /= Double(reviews.count)
                return round(rating*2)/2
            case 3:
                for review in reviews{
                    rating += (review.stats?.vocabulary)!
                }
                rating /= Double(reviews.count)
                return round(rating*2)/2
            default:
                return 0
            }
        }
        return rating
    }
}

