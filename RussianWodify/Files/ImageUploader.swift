//
//  ImageUploader.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 20.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire

struct ImageUploader {
    static func uploadImage (url: String, image: UIImage, name: String, token: String, completion: @escaping (User?, String?) -> Void) {
        
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let header: HTTPHeaders = ["Auth-Token": token]
        let parameters: Parameters = ["avatar_url": image]
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imgData, withName: "avatar_url", fileName: name, mimeType: "jpg/png")
                for (key, value) in parameters {
                    if value is String || value is Int {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
        },
            to: url,
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = value as! [String: Any]
                            completion(User (JSON: json)!, nil)
                        default:
                            completion (nil, "Error")
                        }
                    }
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                }
        })
    }
}
