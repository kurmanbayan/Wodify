//
//  PasswordReset.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/11/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Alamofire

struct Password {
    
    static func resetPassword(_ email: String, completion: @escaping (String?) -> Void) {
        let url = "http://18.194.225.248/main/reset_password/"
        let parameters = ["username": email]
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    completion("На вашу почту отправлен e-mail с инструкцией по восстановлению пароля")
                case 16:
                    completion("Пользователь с такой почтой не существует")
                default:
                    completion("other problem")
                }
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
    
    static func setNewPassword(_ current_password: String, _ new_password: String, completion: @escaping (String?) -> Void) {
        let url = "http://18.194.225.248/main/change_password/"
        let parameters = [
            "current_password": current_password,
            "new_password": new_password
        ]
        print(current_password)
        print(new_password)
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                print(json)
                switch code {
                case 0: completion("Ваш пароль удачно обновлен")
                case 3: completion(json["message"] as? String)
                default: completion("other problem")
                }
            case .failure(let error):
                completion(error.localizedDescription)
            }
        }
    }
}
