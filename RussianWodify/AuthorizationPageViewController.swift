//
//  AuthorizationPageViewController.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 20.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


class AuthorizationPageViewController: UIViewController, NVActivityIndicatorViewable {
    // MARK: - outlets
    @IBOutlet weak var smthRoundAndBlackView: UIView!
    @IBOutlet weak var badEmailOrPassLabel: UILabel!
    @IBOutlet weak var upView: UIView!
    @IBOutlet weak var downView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smthRoundAndBlackView.roundCorners(.allCorners, radius: 100)
        smthRoundAndBlackView.backgroundColor = .black
        badEmailOrPassLabel.isHidden = true
    }
    @IBAction func forgetPasswordBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "resetId", sender: nil)
    }
    
    @IBOutlet private weak var emailTextField: UITextField! {
        didSet {
            emailTextField.delegate = self
        }
    }
    
    @IBOutlet private weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    
    // MARK: functions
    
    @IBAction func enterAction(_ sender: UIButton) {
        showProfilePage()
    }
    
    
    private func checkEmail(_ text: String) -> Bool {
        if text.characters.count < 5 {
            return false
        }
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
        return emailPredicate.evaluate(with: text)
    }
    
    private func check(_ email: String, _ password: String) {
        if email.characters.count < 5 || password.characters.count < 5 || !checkEmail (email) {
            badEmailOrPassLabel.isHidden = false
            UIView.animate(withDuration: 0.9, animations: {
                self.upView.backgroundColor = .red
                self.downView.backgroundColor = .red
            })
            return
        }
        
        startAnimating()
        User.authorize(email, password) { user, message in
            self.stopAnimating()
            if let message = message {
                self.badEmailOrPassLabel.isHidden = false
                print(message)
                return
            } else {
                print(user!)
                Storage.user = user
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "mainStoryboardId") as UIViewController
                
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func showProfilePage() {
        check(emailTextField.text!, passwordTextField.text!)
    }
    
}

extension AuthorizationPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        showProfilePage()
        return true
    }
}

