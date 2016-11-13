//
//  DetailsViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if User.current.type == UserType.learner{
            switch  indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.AverageRatingCell) as! AverageRatingCell
                cell.totalRatingsLabel.isHidden = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.RatingCell) as! RatingCell
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CommentCell) as! CommentCell
                cell.commentTextView.text = "Your prouncaition very good but you need to care more about ending sounds."
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
                cell.totalRatingsLabel.isHidden = true
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.CommentCell) as! CommentCell
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
            default:
                return 60
            }
        }
    }
}
