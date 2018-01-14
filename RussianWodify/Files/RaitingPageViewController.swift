//
//  RaitingPageViewController.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 15.09.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class RaitingPageViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        tableView.tableFooterView = UIView()
        GetRaiting.getRaiting()
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Raiting View Cell", for: indexPath) as! RaitingViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "User In Raiting View Cell", for: indexPath) as! UserInRaitingViewCell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        }
        return 80
    }
}
