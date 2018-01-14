//
//  WorkoutsForDay.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/23/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct WorkoutsForDay: Mappable {
    
    var is_avail = false
    var max_people = 0
    var start_time = ""
    var end_time = ""
    var registered = 0
    var workoutId: Int? = 0
    var name = ""
    var coach = CoachInfo(JSON: [:])!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        is_avail <- map["avail"]
        max_people <- map["max_people"]
        start_time <- map["start_time"]
        end_time <- map["end_time"]
        registered <- map["registered"]
        name <- map["name"]
        coach <- map["coach"]
        workoutId <- map["id"]
    }
}
