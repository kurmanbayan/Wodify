//
//  ResultsViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/15/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

private struct Constants {
    static let resultCell = "resultCell"
    static let collCell = "colCell"
    
    static let measures = ["День", "Неделя", "Месяц", "Год"]
}

class ResultsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var lastPosition = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSetup()
        swipeGesturesSetup()
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
    
    private func changeHorMenuBar(position: Int, horViewColor: UIColor, textColor: UIColor) {
        UIView.animate(withDuration: 0.6) {
            let indexPath = IndexPath(row: position, section: 0)
            let cell = self.collectionView.cellForItem(at: indexPath) as! ResultsCompCollectionViewCell
            cell.horView.backgroundColor = horViewColor
            cell.nameLabel.textColor = textColor
        }
    }
    
    private func changeDay(_ direction: String) {
        if (direction == "right" && lastPosition != 0) {
            changeHorMenuBar(position: lastPosition, horViewColor: .white, textColor: .rgb(red: 142, green: 142, blue: 147))
            lastPosition = lastPosition - 1
        }
        if (direction == "left" && lastPosition != 3) {
            changeHorMenuBar(position: lastPosition, horViewColor: .white, textColor: .rgb(red: 142, green: 142, blue: 147))
            lastPosition = lastPosition + 1
        }
        UIView.animate(withDuration: 0.6) {
            self.changeHorMenuBar(position: self.lastPosition, horViewColor: .rgb(red: 47, green: 128, blue: 237), textColor: .rgb(red: 47, green: 128, blue: 237))
        }
    }

    
    private func viewsSetup() {
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.resultCell, for: indexPath)
        return cell
    }
}

extension ResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return Constants.measures.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ResultsCompCollectionViewCell
        let oldIndex = IndexPath(row: lastPosition, section: 0)
        let oldCell = collectionView.cellForItem(at: oldIndex) as! ResultsCompCollectionViewCell
        
        if indexPath.row != lastPosition {
            UIView.animate(withDuration: 0.6, animations: {
                cell.horView.backgroundColor = .rgb(red: 47, green: 128, blue: 237)
                cell.nameLabel.textColor = .rgb(red: 47, green: 128, blue: 237)
                oldCell.horView.backgroundColor = .white
                oldCell.nameLabel.textColor = .rgb(red: 142, green: 142, blue: 147)
            })
            lastPosition = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.collCell, for: indexPath) as! ResultsCompCollectionViewCell
        cell.nameLabel.text = Constants.measures[indexPath.row]
        
        if indexPath.row == 0 {
            cell.nameLabel.textColor = .rgb(red: 47, green: 128, blue: 237)
            cell.horView.backgroundColor = .rgb(red: 47, green: 128, blue: 237)
        }
        
        return cell
    }
}
