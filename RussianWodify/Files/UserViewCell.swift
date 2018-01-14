//
//  UserViewCell.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 28.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class UserViewCell: UITableViewCell, UIImagePickerControllerDelegate {
    
    // MARK: - outlets
    @IBOutlet weak var muscles: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet private weak var weight: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var settingsBtn: UIButton!
    
    
    var user: UserData? {
        didSet {
            updateUI()
        }
    }
    private func getPersent (_ a: Double, _ b: Double) -> Double {
        let c = b * 100 / a
        return c
    }
    private func updateUI() {
        guard let user = user else { return }
        
        userName.text = user.fullName
        if user.muscles.last != nil {
            let w = user.weight.last!
            weight.text = String (w) + " kg"
            muscles.text = String (getPersent(w, user.muscles.last!)) + " %"
            fat.text = String (getPersent(w, user.fat.last!)) + " %"
        }
        // avatar fixs
        let url = UIViewController.mainUrl + user.imageUrl
        avatarImage.layer.borderWidth = 3.0
        avatarImage.layer.borderColor = UIColor.white.cgColor
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        
        settingsBtn.imageView?.contentMode = .scaleAspectFit
        spinner.isHidden = false
        spinner.startAnimating()
        Storage.getImage(url: url) { image in
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            if let image = image {
                self.avatarImage.image = image
            } else {
                ImageDownloader.fetchImage(with: url) { image in
                    self.avatarImage.image = image
                    Storage.setImage(image: image, url: url)
                }
            }
        }
    }
}

