//
//  WeightViewCell.swift
//  RussianWodify
//
//  Created by Elibay Nuptebek on 14.10.17.
//  Copyright © 2017 Codebusters. All rights reserved.
//

import UIKit
import QuartzCore
import Charts

class FatViewCell: UITableViewCell {
    
    var user: UserData? {
        didSet {
            updateUI()
        }
    }
    var months: [String] = []
    
    @IBOutlet weak var chart: LineChartView!
    
    private func updateUI() {
        if user!.date.isEmpty {
            return
        }
        // changing range
        months = user!.date
        months.insert(user!.date.first!, at: 0)
        months.append(user!.date.last!)
        
        for i in 0..<months.count {
            let str = months[i]
            let startIndex = str.index(str.startIndex, offsetBy: 5)
            months[i] = str.substring(from: startIndex)
        }
        var values = user!.fat
        values.append(user!.fat.last!)
        values.insert(user!.fat.first!, at: 0)
        setChart(Values: values)
    }
    func setChart (Values: [Double]) {
        let color = UIColor(red: 1.0, green: 0.56, blue: 0.0, alpha: 1)
        var dataEntry: [ChartDataEntry] = []
        
        for i in 0..<Values.count {
            let DataEntry = ChartDataEntry (x: Double (i + 1), y: Values[i])
            dataEntry.append (DataEntry)
        }
        let dataSet = LineChartDataSet (values: dataEntry, label: "")
        
        dataSet.circleColors = [color]
        dataSet.circleRadius = 4.0
        dataSet.lineWidth = 2.0
        dataSet.circleHoleRadius = 0.0
        dataSet.colors = [color]
        let data = LineChartData (dataSet: dataSet)
        
        chart.backgroundColor = NSUIColor.clear
        chart.data = data
        chart.chartDescription?.text = ""
        let xaxis = chart.xAxis
        xaxis.valueFormatter = MyXAxisFormatter(months)
    }
    class MyXAxisFormatter: NSObject, IAxisValueFormatter {
        
        let months: [String]
        
        init(_ months: [String]) {
            self.months = months
        }
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return months[Int(value) - 1]
        }
        
    }
}
