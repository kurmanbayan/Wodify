//
//  Storyboard.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 30.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

private struct Constants {
    static let authorizationStoryboard = "Authorization"
    static let authorizationPageController = "navController"
    static let profilePageStoryboard = "ProfilePage"
    static let profilePageController = "Profile Page"
    static let mainStoryboard = "Main"
}
struct Storyboard {

    static var authorizationPage: UIViewController {
        let authorization = UIStoryboard(name: Constants.authorizationStoryboard, bundle: nil)
        return authorization.instantiateViewController(withIdentifier: Constants.authorizationPageController)
    }
    static var mainStoryboardId: UITabBarController {
        let main = UIStoryboard(name: Constants.mainStoryboard, bundle: nil)
        return main.instantiateViewController(withIdentifier: "mainStoryboardId") as! UITabBarController
    }
}
