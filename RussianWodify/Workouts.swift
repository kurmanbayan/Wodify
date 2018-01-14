//
//  Workouts.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/17/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct Workouts: Mappable {
    
    init?(map: Map) {}
    
    var start_date = ""
    var end_date = ""
    var workouts: [Day] = []
      
    mutating func mapping(map: Map) {
        start_date <- map["start_date"]
        end_date <- map["end_date"]
        workouts <- map["workouts"]
    }
    
    static func getWorkouts(_ date: String, _ completion: @escaping (Workouts?, String?) -> Void) {
        let url = "http://18.194.225.248/athlete/get_workouts_of_week/"
    
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        let parameter = [
            "date_of_workout": date
        ]
        
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0: completion(Workouts(JSON: json)!, nil)
                default: completion(nil, "error")
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    static func signToWorkout(_ workout_id: Int, _ athlete_id: Int, _ date_of_workout: String, completion: @escaping (String?, Bool) -> Void) {
        let url = "http://18.194.225.248/athlete/sign_for_workout/"
        
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        let parameter = [
            "workout_id": workout_id,
            "date_of_workout": date_of_workout
        ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    let message = json["message"] as? String
                    completion(message ?? "Вы успешно зарегистрировались на тренировку", true)
                default:
                    let message = json["message"] as! String
                    completion(message, false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func unsignFromWorkout(_ workout_id: Int, _ date_of_workout: String, completion: @escaping (String?, Bool) -> Void) {
        let url = "http://18.194.225.248/athlete/unsign_from_workout/"
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        let parameter = [
            "athlete_id": Storage.user!.athleteId,
            "workout_id": workout_id,
            "date_of_workout": date_of_workout
        ] as [String : Any]
        
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    let message = json["message"] as? String
                    completion(message ?? "Вы отписались от тренировки", true)
                default:
                    let message = json["message"] as! String
                    completion(message, false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func checkForAttendance(_ workout_id: Int, completion: @escaping (Bool?) -> Void) {
        let url = "http://18.194.225.248/main/check_for_attendance/"
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        let parameter = [
            "workout_id": workout_id,
            "athlete_id": Storage.user!.athleteId
        ]
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0:
                    let registered = json["registered"] as? Bool
                    completion(registered)
                default: completion(false)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func addResults(_ workout_id: Int,_ wod_id: Int,_ results: [String: Any], completion: @escaping (String?) -> Void) {
        let url = "http://18.194.225.248/main/check_for_attendance/"
        let header: HTTPHeaders = [
            "Auth-Token": Storage.user!.token
        ]
        let parameter = [
            "workout_id": workout_id,
            "athlete_id": Storage.user!.athleteId,
            "results[]": results,
            "wod_id": wod_id
        ] as [String : Any]
        Alamofire.request(url, method: .post, parameters: parameter, headers: header).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = value as! [String: Any]
                let code = json["code"] as! Int
                switch code {
                case 0: completion("Ваши результаты успешно сохранены")
                default: completion("Произошла ошибка")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

