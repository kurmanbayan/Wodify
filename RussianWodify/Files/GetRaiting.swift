//
//  GetRaiting.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 21.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct GetRaiting: Mappable {
    var curPoistion = ""
    var name = ""
    var surname = ""
    var record = ""
    var exersise = ""
    // MARK: - setting data
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
//        curPoistion <- map["muscles"]
//        name <- map["fat"]
//        surname <- map["weight"]
//        record <- map["date_of_measure"]
//        exersise <- map[""]
    }
    static func getRaiting () {
        let url = UIViewController.mainUrl + "/main/get_global_results/"
        let header: HTTPHeaders = ["Auth-Token": Storage.user!.token]
        print (Storage.user!.token)
        Alamofire.request(url, method: .get, headers: header).responseJSON {  response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                print (json)
                switch code {
                case 0:
                    print ("ok")
                    
                default:
                    print ("error")
                }
            case .failure(let error):
                print ("error")
            }
        }
    }
}
