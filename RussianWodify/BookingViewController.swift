//
//  BookingViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/2/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct Constants{
    static let collectionViewCell = "dayCell"
    static let tableViewCell = "bookingCell"
    static let addResults = "addResults"
    
    static let days = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]

    static let popoverId = "calendarPopover"
    static let calendarVC = "calendarVC"

}

class BookingViewController: UIViewController, NVActivityIndicatorViewable, UIPopoverPresentationControllerDelegate {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dateButton: UIButton!

    var date = Date().dateFormatter(dateFormat: "yyyy-MM-dd").string(from: Date())
 
    var lastPosition = Date().dayOfWeekNumber()
    var data: Workouts!
    var day: [Day] = []
    var workouts: [WorkoutsForDay] = []
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(BookingViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .rgb(red: 47, green: 128, blue: 237)
        
        return refreshControl
    }()

    func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    // segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.popoverId {
            if let calendarVC = segue.destination as? CalendarPopoverViewController {
                calendarVC.modalPresentationStyle = .popover
                calendarVC.popoverPresentationController?.delegate = self
                calendarVC.popoverPresentationController?.sourceView = self.view
                calendarVC.popoverPresentationController?.sourceRect = self.dateButton.frame
                calendarVC.delegate = self
                calendarVC.curDate = date
            }
        }
        if segue.identifier == Constants.addResults {
            if let resultsVC = segue.destination as? AddResultsViewController {
                let index = sender as! Int
                resultsVC.startTime = workouts[index].start_time.crop(from: 0, length: 5)
                let full_name = ("\(workouts[index].coach.first_name) \(workouts[index].coach.last_name)")
                resultsVC.trainerName = full_name
                resultsVC.workoutName = workouts[index].name
            }
        }
    }
    
    private func viewsSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        dateButton.layer.cornerRadius = 10
        self.tableView.addSubview(self.refreshControl)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSetup()
        swipeGesturesSetup()
        getWorkouts(date)
    }

    func getWorkouts(_ date: String) {
        startAnimating()
        Workouts.getWorkouts(date) { (data, message) in
            self.stopAnimating()
            if let message = message {
                self.showAlert(message, "")
            }
            else {
                self.data = data!
                self.day = data!.workouts
                self.workouts = self.day[self.lastPosition].workouts
                let currentWeek = Date().getWeek(startDate: self.data.start_date, endDate: self.data.end_date)
                self.dateButton.setTitle(currentWeek, for: .normal)
                self.tableView.reloadData()
            }
        }
    }
    
    private func signForWorkout(_ workout_id: Int, _ date_of_workout: String) {
        Workouts.signToWorkout(workout_id, Storage.user!.athleteId, date_of_workout) { (message, activity) in
            if let message = message {
                self.showAlert(message, "")
            }
        }
    }
    
    private func unsignFromWorkout(_ workout_id: Int, _ date_of_workout: String) {
        Workouts.unsignFromWorkout(workout_id, date_of_workout) { (message, activity) in
            if let message = message {
                self.showAlert(message, "")
            }
        }
    }
    
    private func swipeGesturesSetup() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.gestureRecognize))
        left.direction = UISwipeGestureRecognizerDirection.left
        self.tableView.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.gestureRecognize))
        right.direction = UISwipeGestureRecognizerDirection.right
        self.tableView.addGestureRecognizer(right)
    }

    func gestureRecognize(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                changeDay("right")
            case UISwipeGestureRecognizerDirection.left:
                changeDay("left")
            default:
                break
            }
        }
    }
    
    private func changeHorMenuBar(position: Int, color: UIColor) {
        UIView.animate(withDuration: 0.6) { 
            let indexPath = IndexPath(row: position, section: 0)
            let cell = self.collectionView.cellForItem(at: indexPath) as! DaysCollectionViewCell
            cell.horView.backgroundColor = color
        }
    }
    
    private func changeDay(_ direction: String) {
        if (direction == "right" && lastPosition != 0) {
            changeHorMenuBar(position: lastPosition, color: .white)
            lastPosition = lastPosition - 1
        }
        if (direction == "left" && lastPosition != 6) {
            changeHorMenuBar(position: lastPosition, color: .white)
            lastPosition = lastPosition + 1
        }
        getWorkouts(date)
        UIView.animate(withDuration: 0.6) {
            self.changeHorMenuBar(position: self.lastPosition, color: .rgb(red: 32, green: 122, blue: 246))
        }
    }
    
    func changeDayFromDate(newDayPos: Int) {
        changeHorMenuBar(position: lastPosition, color: .white)
        changeHorMenuBar(position: newDayPos, color: .rgb(red: 32, green: 122, blue: 246))
        lastPosition = newDayPos
    }
    
    @IBAction func bookingBtnPressed(_ sender: UIButton) {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: pointInTable)!
        let cell = tableView.cellForRow(at: indexPath) as! BookingTableViewCell
        
        let btnTitle: String = cell.bookingBtn.titleLabel!.text!
        if btnTitle == "Записаться" {
            signForWorkout(workouts[indexPath.row].workoutId!, day[indexPath.row].date)
        }
        else if btnTitle == "Отменить\nзапись" {
            unsignFromWorkout(workouts[indexPath.row].workoutId!, day[indexPath.row].date)
        }
        else {
            performSegue(withIdentifier: Constants.addResults, sender: indexPath.row)
        }
        tableView.reloadData()
    }
}

extension BookingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCell, for: indexPath) as! BookingTableViewCell
        cell.setupDesign()
        cell.backgroundColor = .rgb(red: 229, green: 229, blue: 229)
        
        if workouts[indexPath.row].is_avail {
            cell.timeLabel.text = workouts[indexPath.row].start_time.crop(from: 0, length: 5)
            let full_name = ("\(workouts[indexPath.row].coach.first_name) \(workouts[indexPath.row].coach.last_name)")
            cell.trainerNameLabel.text = full_name
            cell.activityTypeLabel.text = workouts[indexPath.row].name
            let limit = ("\(workouts[indexPath.row].registered)/\(workouts[indexPath.row].max_people)")
            cell.joinLimitLabel.text = limit
            
            if let workoutId = workouts[indexPath.row].workoutId {
                Workouts.checkForAttendance(workoutId, completion: { registered in
                    if let register = registered {
                        let full_date = "\(self.day[self.lastPosition].date) \(self.workouts[indexPath.row].start_time)"
                        if let formattedDate = Date().stringToDate(date: full_date, format: "yyyy-MM-dd HH:mm:ss") {
                            if register {
                                if formattedDate <= Date() {
                                    cell.changeToAddResults()
                                }
                                else {
                                    cell.signBtnPressed()
                                }
                            }
                            else {
                                if formattedDate <= Date() {
                                    cell.disableButton()
                                }
                                else {
                                    cell.cancelBtnPressed()
                                }
                            }
                        }
                        else {
                            print("date inputs incorrect")
                        }
                    }
                })
            }
        }
    
        return cell
    }
}

extension BookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DaysCollectionViewCell
        
        let newIndexPath = IndexPath(row: lastPosition, section: 0)
        let oldCell = collectionView.cellForItem(at: newIndexPath) as? DaysCollectionViewCell
        
        if (indexPath.row != lastPosition) {
            UIView.animate(withDuration: 0.6, animations: {
                cell.horView.backgroundColor = .rgb(red: 32, green: 122, blue: 246)
                oldCell?.horView.backgroundColor = .white
            })
            lastPosition = indexPath.row
        }
        getWorkouts(date)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.days.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collectionViewCell, for: indexPath) as! DaysCollectionViewCell
        
        let newIndexPath = IndexPath(row: lastPosition, section: 0)
        let startCell = collectionView.cellForItem(at: newIndexPath) as? DaysCollectionViewCell
        startCell?.horView.backgroundColor = .rgb(red: 32, green: 122, blue: 246)
        
        cell.dayLabel.text = Constants.days[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let width = (view.bounds.width - 32 - 245) / 7
        return width
    }
}

extension BookingViewController: SendDateDelegate {
    func send(value: String) {
        if value != "" {
            if let newPos = Date().stringToDate(date: value, format: "YYYY-mm-dd")?.dayOfWeekNumber() {
                changeDayFromDate(newDayPos: newPos)
            }
            date = value
            getWorkouts(value)
        }
    }
}

