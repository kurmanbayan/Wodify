//
//  UserData.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 17.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
struct UserData {
    var muscles: [Double] = []
    var fat: [Double] = []
    var weight: [Double] = []
    var date: [String] = []
    var fullName: String
    var imageUrl: String
    init (user: User) {
        imageUrl = user.imageUrl
        fullName = user.name + " " + user.lastName
    }
}
