//
//  Component.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/5/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct Component: Mappable {
    
    var id = 0
    var name = ""
    var description = ""
    var score_constr = ScoreInstructor(JSON: [:])!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        score_constr <- map["score_constructor"]
        description <- map["description"]
    }
    
}
