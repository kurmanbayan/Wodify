//
//  Description.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/18/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct Description: Mappable {
    
    var dist = ""
    var description = ""
    var weight = ""
    var rx = false
    var reps = ""
    var rounds = ""
    var header = ""
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        dist <- map["dist"]
        description <- map["description"]
        rx <- map["rx"]
        reps <- map["reps"]
        rounds <- map["rounds"]
        header <- map["header"]
    }
    
}
