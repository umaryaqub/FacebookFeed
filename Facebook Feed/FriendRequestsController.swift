//
//  FriendRequestsController.swift
//  Facebook Feed
//
//  Created by Umar Yaqub on 09/09/2018.
//  Copyright © 2018 Umar Yaqub. All rights reserved.
//

import UIKit

class FriendRequestsController: UITableViewController {
    
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorColor = UIColor.rgb(red: 229, green: 231, blue: 235)
        tableView.sectionHeaderHeight = 26
        
        tableView.register(FriendRequestsCell.self, forCellReuseIdentifier: cellId)
        tableView.register(FriendRequestsHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendRequestsCell
        if indexPath.row % 3 == 0 {
            cell.nameLabel.text = "Mark Zuckerberg"
            cell.requestImageView.image = UIImage(named: "MarkZuck")
        } else if indexPath.row % 3 == 1 {
            cell.nameLabel.text = "Steve Jobs"
            cell.requestImageView.image = UIImage(named: "SteveJobs")
        } else {
            cell.nameLabel.text = "Bill Gates"
            cell.requestImageView.image = UIImage(named: "BillGates")
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! FriendRequestsHeader
        if section == 0 {
            header.nameLabel.text = "FRIEND REQUESTS"
        } else {
            header.nameLabel.text = "PEOPLE YOU MAY KNOW"
        }
        return header
    }
}
