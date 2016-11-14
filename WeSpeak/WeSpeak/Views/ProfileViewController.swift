//
//  ProfileViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/11/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    let skills:[String] = ["Listening", "Pronounciation", "Fluency", "Vocabulary"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Singleton.sharedInstance.partner.review.gift.coke)
        print(Singleton.sharedInstance.partner.review.gift.beer)
        print(Singleton.sharedInstance.partner.review.comment)
        print(Singleton.sharedInstance.partner.review.rating)
        
        loadNib()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    @IBAction func historyButton(_ sender: AnyObject) {
        performSegue(withIdentifier: SegueIdentifier.SegueHistory, sender: self)
    }
    @IBAction func backButton(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    func loadNib(){
        profileTableView.register(UINib(nibName: "InfoCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        profileTableView.register(UINib(nibName: CellIdentifier.ItemCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.ItemCell)
        
         profileTableView.register(UINib(nibName: CellIdentifier.RatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.RatingCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.AverageRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.AverageRatingCell)
        
        profileTableView.register(UINib(nibName: CellIdentifier.QuestionCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.QuestionCell)
        
         profileTableView.register(UINib(nibName: CellIdentifier.SpeakerRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.SpeakerRatingCell)

    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let type = (User.current.type)!
        switch  type {
        case .learner:
            return 4
        case .speaker:
            return 3
        }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as! InfoCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.ItemCell) as! ItemCell
            return cell

        case 2:
            if User.current.type == UserType.learner{
                 let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SpeakerRatingCell) as! SperkerRatingCell
                return cell
            }
            
        case 3:
            if User.current.type == UserType.learner{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RatingCell) as! RatingCell
                cell.skillLabel.text = skills[indexPath.row]
                return cell
            }
            else{
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.QuestionCell) as! QuestionCell
                cell.questionLabel.isHidden = true
                return cell
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 170
        case 2:
            return 110
        default:
            return 40
        }
    }
}
