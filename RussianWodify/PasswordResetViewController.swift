//
//  PasswordResetViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/11/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class PasswordResetViewController: UIViewController {

    @IBOutlet weak var emailTextLabel: UITextField!
    
    private func checkEmail(_ text: String) -> Bool {
        if text.characters.count < 5 {
            return false
        }
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPredicate.evaluate(with: text)
    }
    
    @IBAction func passwordResetBtnPressed(_ sender: UIButton) {
        let emailText = emailTextLabel.text!
        if (checkEmail(emailText)) {
            reset(emailText)
        }
        else {
            self.showAlert("Неправильный формат e-mail", "")
        }
    }
    private func reset(_ text: String) {
        Password.resetPassword(text) { message in
            if let message = message {
                self.showAlert(message, "")
            }
        }
    }
}
