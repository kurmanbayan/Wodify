//
//  User.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 21.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct User: Mappable {
    
    // MARK: - outlets
    var token = ""
    var athleteId = 0
    var email = ""
    var name = ""
    var lastName = ""
    var imageUrl = ""
    
    // MARK: - setting data
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        imageUrl <- map["user.athlete.avatar_url"]
        name <- map["user.athlete.first_name"]
        lastName <- map["user.athlete.last_name"]
        email <- map["user.username"]
        athleteId <- map["user.athlete.id"]
    }
    
    static func authorize (_ email: String, _ password: String, completion: @escaping (User?, String?) -> Void) {
        let parameters = ["username": email, "password": password]
        let url = UIViewController.mainUrl + "/main/login/"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                print (response)
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    print ("\n\n\n\n")
                    print (json)
                    completion(User (JSON: json)!, nil)
                case 16:
                    completion(nil, "Введите правильный email")
                default:
                    print (code)
                    completion (nil, "Введите правильный пароль")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}

