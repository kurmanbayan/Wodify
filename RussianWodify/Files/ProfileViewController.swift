//
//  ProfileViewController.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 25.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LogOutTableViewCell: UITableViewCell {
    @IBOutlet weak var logOutBtn: UIButton!
}

private struct Constants {
    static let userViewCellId = "userInfoCell"
    static let WeightViewCell = "weightInfoCell"
    static let MusclesViewCell = "musclesInfoCell"
    static let FatViewCell = "fatInfoCell"
    static let LogOutCell = "logOutCell"
    
    static let profileToSettingsId = "profileToSettingsId"
}


class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NVActivityIndicatorViewable {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func settingsBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.profileToSettingsId, sender: nil)
    }
    
    @IBAction func imageTapRecognized(_ sender: UITapGestureRecognizer) {
        showAlertSheet(sender)
    }
    var userData: UserData!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBAction func logOutBtnPressed(_ sender: UIButton) {
        Storage.user = nil
        appDelegate.checkStorage()
    }
    
    var user: User! {
        didSet {
            updateUI()
        }
    }
    private func updateUI () {
        tableView.reloadData()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ProfileViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .rgb(red: 47, green: 128, blue: 237)
        
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        getStats()
        refreshControl.endRefreshing()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset.top = 20
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getStats()
        navigationController?.isNavigationBarHidden = true
    }
    func getStats() {
        startAnimating()
        userData = UserData (user: Storage.user!)
        UserStats.getStats() {  userStats, message in
            self.userData.muscles = userStats!.map {$0.muscles}
            self.userData.fat = userStats!.map {$0.fat}
            self.userData.weight = userStats!.map {$0.weight}
            self.userData.date = userStats!.map {$0.date}
            self.stopAnimating()
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch(indexPath.row) {
        case 0:
            return 180
        case 4:
            return 70
        default:
            return 311
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch(indexPath.row) {
        case 0:
            let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.userViewCellId) as! UserViewCell
            userCell.user = userData
            return userCell
        case 1:
            let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.WeightViewCell) as! WeightViewCell
            userCell.user = userData
            return userCell
        case 2:
            let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.MusclesViewCell) as! MusclesViewCell
            userCell.user = userData
            return userCell
        case 3:
            let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.FatViewCell) as! FatViewCell
            userCell.user = userData
            return userCell
        default:
            let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.LogOutCell) as! LogOutTableViewCell
            userCell.logOutBtn.layer.cornerRadius = 10
            return userCell
        }
    }
    
}

extension ProfileViewController {
    
    func showAlertSheet(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction (title: "Открыть изображение", style: .default, handler: { (action: UIAlertAction) in
            self.imageTapped(image: imageView.image!)
        }))
        actionSheet.addAction(UIAlertAction (title: "Изменить изображение, камера", style: .default, handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present (imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction (title: "Изменить изображение, библиотека", style: .default, handler: {(action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present (imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction (title: "Отмена", style: .cancel, handler: nil))
        self.present (actionSheet, animated: true, completion: nil)
        
        navigationController?.isNavigationBarHidden = true
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imageTapped(image: UIImage) {
        let newImageView = UIImageView(image: image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.navigationController?.isNavigationBarHidden = true
        self.view.addSubview(newImageView)
        
    }
    
    func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = true
        sender.view?.removeFromSuperview()
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        startAnimating()
        let token = Storage.user!.token
        ImageUploader.uploadImage(url: UIViewController.mainUrl + "/athlete/update_profile/", image: image, name: Storage.user!.imageUrl, token: token) {
            result, message in
            Storage.user = result
            Storage.user!.token = token
            self.viewDidLoad()
            self.stopAnimating()
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
