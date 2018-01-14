//
//  Wod.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/9/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct Wod: Mappable {
    
    init?(map: Map) { }

    var date = Date()
    var id = 0
    var name = ""
    var sections: [Section] = []
    var programName = ""
 
    mutating func mapping(map: Map) {
        date <- map["wod.date_of_wod"]
        id <- map["wod.id"]
        programName <- map["wod.program.name"]
        sections <- map["components"]
    }
    
    static func get(completion: @escaping (Wod?, String?) -> Void) {
        let url = "http://18.194.225.248/athlete/wod_for_today/"
        
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        
        Alamofire.request(url, method: .get, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0: completion(Wod(JSON: json)!, nil)
                default:
                    let message = json["message"] as! String
                    completion(nil, message)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
