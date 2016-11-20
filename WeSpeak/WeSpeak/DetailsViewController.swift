//
//  DetailsViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var review:Review?
    @IBOutlet weak var detailTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNib()
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.reloadData()
    }
    

    func loadNib(){
       detailTableView.register(UINib(nibName: CellIdentifier.RatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.RatingCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.AverageRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.AverageRatingCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.CommentCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.CommentCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.PlayRecordCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.PlayRecordCell)
        
        detailTableView.register(UINib(nibName: CellIdentifier.SpeakerRatingCell, bundle: nil), forCellReuseIdentifier: CellIdentifier.SpeakerRatingCell)
        
    }
    @IBAction func onBackButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(User.current.type == UserType.learner){
            return 4
        }
        else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            if User.current.type == UserType.learner{
                return 4
            }
        default:
            return 1
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if User.current.type == UserType.learner{
            switch  indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                cell.totalRatingsLabel.isHidden = true
                cell.review = review
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RatingCell) as! RatingCell
                cell.skillLabel.text = Singleton.skills[indexPath.row]
                switch indexPath.row{
                case 0:
                    cell.ratingControl.rating = (review?.stats?.listening)!
                case 1:
                    cell.ratingControl.rating = (review?.stats?.pronounciation)!
                case 2:
                    cell.ratingControl.rating = (review?.stats?.fluency)!
                case 3:
                    cell.ratingControl.rating = (review?.stats?.vocabulary)!
                default:
                    break
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CommentCell) as! CommentCell
                cell.commentTextView.text = review?.comment
                cell.commentTextView.isEditable = false
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PlayRecordCell) as! PlayRecordCell
                return cell
            default:
                return UITableViewCell()
            }
        }
        else{
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.SpeakerRatingCell) as! SperkerRatingCell
                cell.ratingControl.rating = (review?.rating)!
                cell.totalRatingsLabel.isHidden = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CommentCell) as! CommentCell
                cell.commentTextView.text = review?.comment
                cell.commentTextView.isEditable = false
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.PlayRecordCell) as! PlayRecordCell
                return cell
            default:
                return UITableViewCell()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if User.current.type == UserType.learner{
            switch indexPath.section {
            case 0:
                return 90
            case 2:
                return 120
            default:
                return 40
            }
        }
        else{
            switch indexPath.section {
            case 0:
                return 80
            case 1:
                return 120
            default:
                return 60
            }
        }
    }
}
