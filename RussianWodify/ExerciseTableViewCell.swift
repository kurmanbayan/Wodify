//
//  ExerciseTableViewCell.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/4/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class ExerciseTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseTypeLabel: UILabel!
    @IBOutlet weak var exerciseLogo: UIImageView!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func detailsBtnPressed(_ sender: UIButton) {
        
    }
}
