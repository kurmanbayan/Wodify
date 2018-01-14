//
//  UIViewControllerExtension.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 31.07.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static let color = UIColor (red: 4/255, green: 152/255, blue: 166/255, alpha: 1)
    static let mainUrl = "http://18.194.225.248"
    
    func showAlert(_ message: String, _ title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension String {
    func crop(from: Int, length: Int) -> String! {
        let startIndex = self.index(self.startIndex, offsetBy: from)
        
        var result = self.substring(from: startIndex)
        
        let endIndex = result.index(result.startIndex, offsetBy: length)
        result = result.substring(to: endIndex)
        
        return result
    }
    func stringToInt(data: String) -> Int {
        let values = data.components(separatedBy: "").flatMap { Int($0.trimmingCharacters(in: .whitespaces)) }
        let sum = values.reduce(0, +)
        return sum
    }
}

extension Date {
    
    func dayOfWeekName() -> String? {
        let getDayName = ["Воскресенье", "Понедельник", "Вторник",
                                  "Среда", "Четверг", "Пятница", "Суббота"]

        let curDate = Calendar.current.dateComponents([.weekday], from: self).weekday
        return getDayName[curDate! - 1]
    }
    func dayOfWeekNumber() -> Int {
        let curDate = Calendar.current.dateComponents([.weekday], from: self).weekday
        return (curDate! + 5) % 7
    }
    
    func dateFormatter(dateFormat: String) -> DateFormatter {
        let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat
            return formatter
        }()
        
        return formatter
    }
    
    func getWeek(startDate: String, endDate: String) -> String {
        
        let startDay = startDate.crop(from: 8, length: 2)
        let endDay = endDate.crop(from: 8, length: 2)
        let month = startDate.crop(from: 5, length: 2)
        
        let startPos = startDay!.stringToInt(data: startDay!)
        let endPos = endDay!.stringToInt(data: endDay!)
        let monthPos = month!.stringToInt(data:  month!)
        
        let monthNames = ["Января", "Февраля", "Марта", "Апреля", "Мая", "Июня", "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"]
        
        return "\(startPos)-\(endPos) \(monthNames[monthPos - 1])"
    }
    
    func stringToDate(date: String, format: String) -> (Date)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: date)
        return date
    }
}




