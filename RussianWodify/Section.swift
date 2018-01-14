//
//  Section.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/5/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import ObjectMapper

struct Section: Mappable {
    
    var component = Component(JSON: [:])!
    var description = Description(JSON: [:])!
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        component <- map["component"]
        description <- map["description"]
    }
    
}
