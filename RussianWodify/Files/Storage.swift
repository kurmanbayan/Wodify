//
//  Storage.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 30.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Cache

private struct Caches {
    static let jsonCache = SpecializedCache < JSON > (name: "JSON Cache")
    static let imageCache = SpecializedCache < UIImage > (name: "UIImage Cache")
}
private struct Constants {
    static let user = "User"
    static let image = "Image"
}

struct Storage {
    // image view
    static func setImage (image: UIImage, url: String) {
        Caches.imageCache.async.addObject(image, forKey: url)
    }
    
    static func getImage(url: String, completion: @escaping (UIImage?) -> Void) {
        Caches.imageCache.async.object(forKey: url, completion: completion)
    }
    
    static var user: User? {
        get {
            if let json = Caches.jsonCache.object(forKey: Constants.user) {
                switch json {
                case .dictionary(let userJson): return User (JSON: userJson)!
                default: break
                }
            }
            return nil
        }
        set {
            if let user = newValue {
                try! Caches.jsonCache.addObject(JSON.dictionary (user.toJSON()), forKey: Constants.user)
            }
            else {
                try! Caches.jsonCache.removeObject(forKey: Constants.user)
            }
        }
    }
}
