//
//  userStats.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 13.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct UserStats: Mappable {
    // MARK: - outlets
    var muscles = 0.0
    var fat = 0.0
    var weight = 0.0
    var date = ""
    // MARK: - setting data
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        muscles <- map["muscles"]
        fat <- map["fat"]
        weight <- map["weight"]
        date <- map["date_of_measure"]
    }
    
    static func getStats (completion: @escaping ([UserStats]?, String?) -> Void) {
        let url = UIViewController.mainUrl + "/athlete/get_measure_info/"
        let header: HTTPHeaders = ["Auth-Token": Storage.user!.token]
        let parameter = ["athlete_id": Storage.user!.athleteId] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON {  response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    let a = json["results"] as! [[String:Any]]
                    completion(a.map { UserStats (JSON: $0)! }, nil)
                default:
                    completion (nil, "Введите правильный пароль")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
