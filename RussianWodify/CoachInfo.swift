//
//  CoachInfo.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/23/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct CoachInfo: Mappable {
    init?(map: Map) { }
    
    var first_name = ""
    var last_name = ""
    var avatar_url = ""
    
    mutating func mapping(map: Map) {
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        avatar_url <- map["avatar_url"]
    }
}
