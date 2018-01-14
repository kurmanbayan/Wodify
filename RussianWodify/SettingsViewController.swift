//
//  SettingsViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/11/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController {
    
    @IBOutlet weak var currentPasswordTextLabel: UITextField!
    @IBOutlet weak var newPasswordTextLabel: UITextField!
    @IBOutlet weak var confirmNewPasswordTextLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func clearTextFields() {
        currentPasswordTextLabel.text = ""
        newPasswordTextLabel.text = ""
        confirmNewPasswordTextLabel.text = ""
    }
    
    
    // password settings
    @IBAction func setNewPasswordBtnPressed(_ sender: UIButton) {
        let new_pass = self.newPasswordTextLabel.text!
        let cur_pass = self.currentPasswordTextLabel.text!
        if new_pass == self.confirmNewPasswordTextLabel.text! {
            Password.setNewPassword(cur_pass, new_pass, completion: { message in
                if let message = message {
                    self.showAlert(message, "")
                }
            })
        } else {
            self.showAlert("Введённые пароли не совпадают", "")
        }
    }
    
    
}
