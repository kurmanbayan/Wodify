//
//  ImageDownolader.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 21.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import AlamofireImage
import Alamofire

struct ImageDownloader {
    static func fetchImage(with url: String, completion: @escaping (UIImage) -> Void) {
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                completion(image)
            }
        }
    }
}
