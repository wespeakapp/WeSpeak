//
//  HistoryViewController.swift
//  WeSpeak
//
//  Created by Quoc Huy Ngo on 11/12/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    override func viewDidLoad() {
        historyTableView.delegate = self
        historyTableView.dataSource = self
        historyTableView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        let nc = segue.destination as! UINavigationController
        let vc = nc.topViewController as! DetailsViewController
        let index = historyTableView.indexPathForSelectedRow?.row
        vc.review = User.current.reviews[index!]
    }

}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.current.reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        cell.nameLabel.text = User.current.reviews[indexPath.row].partner
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SegueIdentifier.SegueDetail, sender: self)
    }
}
