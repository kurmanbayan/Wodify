//
//  Day.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/23/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct Day: Mappable {

    var day_id = 0
    var date = ""
    var workouts: [WorkoutsForDay] = []
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        day_id <- map["day_id"]
        date <- map["date_of_workout"]
        workouts <- map["workouts"]
    }
    
}
