//
//  CalendarPopoverViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/20/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import FSCalendar

protocol SendDateDelegate {
    func send(value: String)
}

class CalendarPopoverViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    var curDate: String?
    var lastSelectedDate: String?
    var delegate: SendDateDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.dataSource = self
        calendar.delegate = self
        self.preferredContentSize = CGSize(width: 375, height: 220)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        lastSelectedDate = Date().dateFormatter(dateFormat: "yyyy-MM-dd").string(from: date)
        if delegate != nil {
            if let date = lastSelectedDate {
                delegate?.send(value: date)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        let dateString = Date().dateFormatter(dateFormat: "yyyy-MM-dd").string(from: date)
        let date = Date().dateFormatter(dateFormat: "yyyy-MM-dd").string(from: Date())
        if let lastDate = curDate {
            if dateString == lastDate && dateString != date {
                return .blue
            }
        }
        return nil
    }

}
