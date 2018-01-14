//
//  ContainerViewController.swift
//  RussianWodify
//
//  Created by Kurnmanbay Ayan on 9/11/17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var firstContainerView: UIView!
    @IBOutlet weak var secondContainerView: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstContainerView.isHidden = true
        segmentControllerSetup()
    }
    
    @IBAction func segmentControllerTapped(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            secondContainerView.isHidden = true
            firstContainerView.isHidden = false
        }
        else {
            secondContainerView.isHidden = false
            firstContainerView.isHidden = true
        }
    }
    
    private func segmentControllerSetup() {
        let frame = segmentController.frame
        let width = view.bounds.width - 32
        segmentController.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: 30)
    
        let font = UIFont.systemFont(ofSize: 13)
        segmentController.setTitleTextAttributes([NSFontAttributeName: font],
                                              for: .normal)
    }
}
