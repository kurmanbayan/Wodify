//
//  ScoreInstructor.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/18/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct ScoreInstructor: Mappable {
    
    var id = 0
    var scoring = Scoring(JSON: [:])!

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        scoring <- map["scoring"]
    }
    
}
