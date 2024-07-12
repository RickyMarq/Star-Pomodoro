//
//  SummaryController.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 01/10/23.
//

import UIKit
import DGCharts

class SummaryController: UIViewController {
    
    var summaryView: SummaryView?
    let dummyTagArray = ["Study", "Work", "Programming"]
    let dummyTagValues: [Double] = [12, 22, 10]
    
    override func loadView() {
        self.summaryView = SummaryView()
        self.view = summaryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.summaryView?.pieChartDelegate(delegate: self)
        self.summaryView?.delegate(delegate: self)
        //         self.setDataCount(Int(sliderX.value), range: UInt32(sliderY.value))
        self.setData(3, range: 3)
        self.setBarChartData()
    }
}

//func setDataCount(_ count: Int, range: UInt32) {
//    let entries = (0..<count).map { (i) -> PieChartDataEntry in
//        // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
//        return PieChartDataEntry(value: Double(arc4random_uniform(range) + range / 5),
//                                 label: parties[i % parties.count],
//                                 icon: #imageLiteral(resourceName: "icon"))
//    }

extension SummaryController: ChartViewDelegate {
    
    func setData(_ count: Int, range: UInt32) {
        let entries = (0..<count).map { (i) -> PieChartDataEntry in
            
            return PieChartDataEntry(value: dummyTagValues[i % dummyTagValues.count], label: dummyTagArray[i % dummyTagArray.count])
        }
        
//        let entrie: [PieChartDataEntry] = [PieChartDataEntry(value: 12, label: "Study"), PieChartDataEntry(value: 33, label: "Programming"), PieChartDataEntry(value: 33, label: "Exercise")]
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false

        set.sliceSpace = 3
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"

        data.setValueFont(.systemFont(ofSize: 12, weight: .bold))
        data.setValueTextColor(.label)
        
        self.summaryView?.pieChart.data = data
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
    
    func setBarChartData() {
        let entrie: [BarChartDataEntry] = [BarChartDataEntry(x: 1, y: 0.001), BarChartDataEntry(x: 2, y: 0.001), BarChartDataEntry(x: 3, y: 0.001), BarChartDataEntry(x: 4, y: 0.001), BarChartDataEntry(x: 5, y: 0.001), BarChartDataEntry(x: 6.0, y: 0.001), BarChartDataEntry(x: 7.0, y: 0.001), BarChartDataEntry(x: 8.0, y: 0.001), BarChartDataEntry(x: 9.0, y: 0.001), BarChartDataEntry(x: 10.0, y: 0.001), BarChartDataEntry(x: 11.0, y: 0.001),BarChartDataEntry(x: 12.0, y: 0.001), BarChartDataEntry(x: 13.0, y: 0.001), BarChartDataEntry(x: 14.0, y: 0.001), BarChartDataEntry(x: 15.0, y: 0.001), BarChartDataEntry(x: 16.0, y: 0.001), BarChartDataEntry(x: 17.0, y: 0.001), BarChartDataEntry(x: 18.0, y: 0.001), BarChartDataEntry(x: 19.0, y: 0.001), BarChartDataEntry(x: 20.0, y: 0.001), BarChartDataEntry(x: 21.0, y: 0.001), BarChartDataEntry(x: 22.0, y: 0.001), BarChartDataEntry(x: 23.0, y: 0.001), BarChartDataEntry(x: 24, y: 0.001),]
        
        let set = BarChartDataSet(entries: entrie, label: "")
        let data = BarChartData(dataSet: set)
        set.colors = [.systemYellow]
        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"

        self.summaryView?.focusedBarChart.data = data
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    }
}

extension SummaryController: SummaryViewProtocol {
   
    func cancelButtonAction() {
        self.dismiss(animated: true)
    }
}
