//
//  BookingTableViewCell.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/2/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var activityTypeLabel: UILabel!
    @IBOutlet weak var trainerNameLabel: UILabel!
    @IBOutlet weak var joinLimitLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var bookingBtn: UIButton!

    @IBOutlet weak var regImageView: UIImageView!
    @IBOutlet weak var cancelBackView: UIView!
    
    // constraints
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    
    func setupDesign() {
        trainerNameLabel.font = UIFont(name: "Roboto-Regular", size: 15)
        cellView.layer.cornerRadius = 5
        bookingBtn.titleLabel?.textAlignment = NSTextAlignment.center
        cancelBackView.layer.cornerRadius = 6
        regImageView.isHidden = true
    }
    
    private func btnPressed(isHidden: Bool, topC: CGFloat, heightC: CGFloat, btnTitle: String, btnBackColor: UIColor, cellColor: UIColor, mainColor: UIColor, btnFontSz: CGFloat, btnFontColor: UIColor, trainerLabelColor: UIColor, alpha: CGFloat) {
        joinLimitLabel.isHidden = isHidden
        regImageView.isHidden = !isHidden
        topConstraint.constant = topC
        heightContraint.constant = heightC
        cancelBackView.backgroundColor = btnBackColor
        cellView.backgroundColor = cellColor
        timeLabel.textColor = mainColor
        activityTypeLabel.textColor = mainColor
        trainerNameLabel.textColor = trainerLabelColor
        trainerNameLabel.alpha = alpha
        bookingBtn.setTitle(btnTitle, for: .normal)
        bookingBtn.setTitleColor(btnFontColor, for: .normal)
        bookingBtn.titleLabel?.font = UIFont(name: (bookingBtn.titleLabel?.font.fontName)!, size: btnFontSz)
    }
    
    func signBtnPressed() {
        btnPressed(isHidden: true, topC: 6, heightC: 29, btnTitle: "Отменить\nзапись", btnBackColor: .rgb(red: 113, green: 174, blue: 255), cellColor: .rgb(red: 47, green: 128, blue: 237), mainColor: .white, btnFontSz: 15, btnFontColor: .white, trainerLabelColor: .white, alpha: 0.7)
        bookingBtn.isEnabled = true
    }
    func cancelBtnPressed() {
        btnPressed(isHidden: false, topC: 4, heightC: 20, btnTitle: "Записаться", btnBackColor: .white, cellColor: .white, mainColor: .black, btnFontSz: 17, btnFontColor: .rgb(red: 47, green: 128, blue: 237), trainerLabelColor: .rgb(red: 142, green: 142, blue: 147), alpha: 1)
        bookingBtn.isEnabled = true
    }
    
    func changeToAddResults() {
        btnPressed(isHidden: true, topC: 6, heightC: 29, btnTitle: "Отметить\nрезультаты", btnBackColor: .rgb(red: 0, green: 83, blue: 196), cellColor: .rgb(red: 47, green: 128, blue: 237), mainColor: .white, btnFontSz: 15, btnFontColor: .white, trainerLabelColor: .white, alpha: 0.7)
        bookingBtn.isEnabled = true
    }
    
    func disableButton() {
        
        btnPressed(isHidden: false, topC: 4, heightC: 20, btnTitle: "Записаться", btnBackColor: .white, cellColor: .white, mainColor: .rgb(red: 188,green: 187,blue: 193), btnFontSz: 17, btnFontColor: .rgb(red: 188,green: 187,blue: 193), trainerLabelColor: .rgb(red: 188,green: 187,blue: 193), alpha: 1)
        bookingBtn.isEnabled = false
    }
    
}
