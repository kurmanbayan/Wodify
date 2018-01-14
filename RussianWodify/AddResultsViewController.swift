//
//  AddResultsViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/12/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit


private struct Constants {
    static let resultCell = "resultCell"
}

class AddResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var trainerNameLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var workoutNameLabel: UILabel!
        
    let types = ["Reps", "Weight"]
    
    var trainerName = ""
    var startTime = ""
    var workoutName = ""
    
    var wods: Wod!
    var section: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetup()
        rightNavBarButtonSetup()
        getWOD()
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
    
    func viewSetup() {
        trainerNameLabel.text = "Тренер: \(trainerName)"
        startTimeLabel.text = startTime
        workoutNameLabel.text = workoutName

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func rightNavBarButtonSetup() {
        let btn = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonPressed))
        self.navigationItem.setRightBarButton(btn, animated: true)
    }
    
    func saveButtonPressed() {
        for col in 0...self.section.count - 1 {
            print(col)
            for row in 0...1 {
                let indexPath = IndexPath(row: row, section: col)
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.resultCell, for: indexPath) as! ResultsTableViewCell
                print(cell.resultTextField.text ?? "error")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section].description.header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.resultCell, for: indexPath) as! ResultsTableViewCell
        cell.workoutNameLabel.text = types[indexPath.row]

        cell.resultTextField.placeholder = types[indexPath.row]
        return cell
    }
}
