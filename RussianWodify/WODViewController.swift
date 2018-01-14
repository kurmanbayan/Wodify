//
//  WODViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 8/4/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private struct Constants {
    static let exerciseCell = "exerciseCell"
    static let instructionCell = "instructionCell"
    static let topCell = "topCell"
    static let bottomCell = "bottomCell"
    static let wodToResults = "wodToResults"
}

class WODViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wodNameLabel: UILabel!
    @IBOutlet weak var dayNameLabel: UILabel!
   
    var wods: Wod!
    var section: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getWOD()
        viewSetup()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(WODViewController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = .rgb(red: 47, green: 128, blue: 237)
        
        return refreshControl
    }()
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        getWOD()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func addResultsBtnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.wodToResults, sender: nil)
    }
    
    private func getWOD() {
        Wod.get { (wod, message) in
            if let message = message {
                print(message)
                self.showAlert(message, "")
            }
            else {
                self.wods = wod!
                self.section = self.wods.sections
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func detailsBtnPressed(_ sender: UIButton) {
        let pointInTable: CGPoint = sender.convert(sender.bounds.origin, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: pointInTable)!
        let desc = section[indexPath.row].component.description
        let name = section[indexPath.row].description.header
        self.showAlert(desc, name)
    }
    
    private func viewSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableViewAutomaticDimension
        dayNameLabel.text = Date().dayOfWeekName()
        self.tableView.addSubview(self.refreshControl)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.exerciseCell, for: indexPath) as! ExerciseTableViewCell
        cell.mainView.layer.cornerRadius = 10
        cell.backgroundColor = .rgb(red: 229, green: 229, blue: 229)
        
        let desc = section[indexPath.row].description.description
        /*let weight = section[indexPath.row].description.weight
        let rx = section[indexPath.row].description.rx
        let reps = section[indexPath.row].description.reps
        let rounds = section[indexPath.row].description.rounds
        */
        
        cell.exerciseTypeLabel.text = section[indexPath.row].description.header
        cell.descriptionLabel.text = desc
    
        return cell
    }

}
