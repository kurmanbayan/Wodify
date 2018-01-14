//
//  Scoring.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/5/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct Scoring: Mappable {
    
    var id = 0
    var name = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
    
}

