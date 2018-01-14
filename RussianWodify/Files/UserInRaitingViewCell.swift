//
//  UserInRaitingViewCell.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 07.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class UserInRaitingViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var curPosition: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var record: UILabel!
    @IBOutlet weak var fullName: UILabel!
//    var user: UserInRaiting {
//        didSet {
//            updateUI()
//        }
//    }
    func updateUI () -> Void {
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

