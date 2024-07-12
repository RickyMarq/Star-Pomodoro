//
//  SummaryView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 01/10/23.
//

import UIKit
import DGCharts

protocol SummaryViewProtocol: AnyObject {
    func cancelButtonAction()
}

class SummaryView: UIView {
    
    let xAxisLabels = ["00:00", "06:00", "12:00", "18:00", "23:00"]
    
    weak var delegate: SummaryViewProtocol?
    
    func delegate(delegate: SummaryViewProtocol) {
        self.delegate = delegate
    }
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .secondarySystemBackground
        return scrollView
    }()
    
    lazy var summaryViewContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var summaryViewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Summary"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemBackground
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()

    lazy var summaryViewHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var summaryViewHeaderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()

    @objc func cancelButtonTapped() {
        self.delegate?.cancelButtonAction()
    }
    
    lazy var summarySegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Day", "Month", "Year"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 2
        return segmentedControl
    }()
    
    lazy var tagDistributionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    lazy var focusedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Tag Distribution"
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var tagDistributionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var pieChart: PieChartView = {
        let pieChart = PieChartView()
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        pieChart.entryLabelColor = .systemYellow
        pieChart.holeColor = .tertiarySystemBackground
        pieChart.drawHoleEnabled = true
        pieChart.tintColor = .systemYellow
        pieChart.entryLabelFont = .systemFont(ofSize: 12, weight: .light)
        pieChart.layer.shadowColor = UIColor.secondarySystemBackground.cgColor
        pieChart.layer.shadowOpacity = 0.5
        pieChart.layer.shadowOffset = CGSize(width: 0, height: 4)
        pieChart.layer.shadowRadius = 4
  //      pieChart.usePercentValuesEnabled = true
        pieChart.isUserInteractionEnabled = false
        return pieChart
    }()
    
    
    func pieChartDelegate(delegate: ChartViewDelegate) {
        self.pieChart.delegate = delegate
    }
    
    lazy var focusedTimeDistributionView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    lazy var focusedTimeDistributionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "Focused Time Distribution"
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    lazy var focusedDistributionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var focusedBarChart: BarChartView = {
        let barChart = BarChartView()
        barChart.translatesAutoresizingMaskIntoConstraints = false
        barChart.fitBars = true
        barChart.pinchZoomEnabled = false
        barChart.chartDescription.enabled = false
        let leftAxis = barChart.leftAxis
        barChart.rightAxis.enabled = false
        barChart.animate(xAxisDuration: 3)
        barChart.animate(yAxisDuration: 3)

        barChart.pinchZoomEnabled = false
 //       leftAxis.setLabelCount(6, force: true)
 //       leftAxis.labelPosition = .outsideChart
        barChart.leftAxis.enabled = false
        barChart.xAxis.labelPosition = .bottom
        let xAxisLabels = ["00:00", "06:00", "12:00", "18:00", "23:00"]
 //       barChart.xAxis.setLabelCount(5, force: true)
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: xAxisLabels)
  return barChart
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension SummaryView: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.summaryViewContentView)
        self.summaryViewContentView.addSubview(self.summaryViewStackView)

        
        self.summaryViewStackView.addArrangedSubview(self.summaryViewHeader)
        self.summaryViewHeader.addSubview(self.summaryViewHeaderStackView)
        
        self.summaryViewHeaderStackView.addArrangedSubview(self.summaryLabel)
        self.summaryViewHeaderStackView.addArrangedSubview(self.cancelButton)
        
        
        self.summaryViewStackView.addArrangedSubview(self.summarySegmentedControl)
        // -- //
        self.summaryViewStackView.addArrangedSubview(self.focusedTimeDistributionView)
        self.focusedTimeDistributionView.addSubview(self.focusedDistributionStackView)
        self.focusedDistributionStackView.addArrangedSubview(self.focusedTimeDistributionLabel)
        self.focusedDistributionStackView.addArrangedSubview(self.focusedBarChart)
        // -- //
        self.summaryViewStackView.addArrangedSubview(self.tagDistributionView)
        self.tagDistributionView.addSubview(self.tagDistributionStackView)
        self.tagDistributionStackView.addArrangedSubview(self.focusedTimeLabel)
        self.tagDistributionStackView.addArrangedSubview(self.pieChart)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
            self.scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor),
            self.scrollView.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            self.summaryViewContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.summaryViewContentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.summaryViewContentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.summaryViewContentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.summaryViewContentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

            self.summaryViewStackView.topAnchor.constraint(equalTo: self.summaryViewContentView.topAnchor, constant: 20),
            self.summaryViewStackView.leadingAnchor.constraint(equalTo: self.summaryViewContentView.leadingAnchor, constant: 20),
            self.summaryViewStackView.trailingAnchor.constraint(equalTo: self.summaryViewContentView.trailingAnchor, constant: -20),
            self.summaryViewStackView.bottomAnchor.constraint(equalTo: self.summaryViewContentView.bottomAnchor, constant: -20),
            
            self.summaryViewHeaderStackView.topAnchor.constraint(equalTo: self.summaryViewHeader.topAnchor, constant: 10),
            self.summaryViewHeaderStackView.leadingAnchor.constraint(equalTo: self.summaryViewHeader.leadingAnchor, constant: 10),
            self.summaryViewHeaderStackView.trailingAnchor.constraint(equalTo: self.summaryViewHeader.trailingAnchor, constant: -10),
            self.summaryViewHeaderStackView.bottomAnchor.constraint(equalTo: self.summaryViewHeader.bottomAnchor, constant: -10),
            
            self.cancelButton.heightAnchor.constraint(equalToConstant: 30),
            self.cancelButton.widthAnchor.constraint(equalToConstant: 30),
            
            
            self.summarySegmentedControl.heightAnchor.constraint(equalToConstant: 24),
            
            self.tagDistributionStackView.topAnchor.constraint(equalTo: self.tagDistributionView.topAnchor, constant: 10),
            self.tagDistributionStackView.leadingAnchor.constraint(equalTo: self.tagDistributionView.leadingAnchor, constant: 10),
            self.tagDistributionStackView.trailingAnchor.constraint(equalTo: self.tagDistributionView.trailingAnchor, constant: -10),
            self.tagDistributionStackView.bottomAnchor.constraint(equalTo: self.tagDistributionView.bottomAnchor, constant: -10),
        
            self.pieChart.heightAnchor.constraint(equalToConstant: 300),
            self.pieChart.widthAnchor.constraint(equalToConstant: 300),

            self.focusedDistributionStackView.topAnchor.constraint(equalTo: self.focusedTimeDistributionView.topAnchor, constant: 10),
            self.focusedDistributionStackView.leadingAnchor.constraint(equalTo: self.focusedTimeDistributionView.leadingAnchor, constant: 10),
            self.focusedDistributionStackView.trailingAnchor.constraint(equalTo: self.focusedTimeDistributionView.trailingAnchor, constant: -10),
            self.focusedDistributionStackView.bottomAnchor.constraint(equalTo: self.focusedTimeDistributionView.bottomAnchor, constant: -10),
            
            self.focusedBarChart.heightAnchor.constraint(equalToConstant: 300),
            self.focusedBarChart.widthAnchor.constraint(equalToConstant: 300),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
    
}

extension SummaryView: AxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: DGCharts.AxisBase?) -> String {
        return xAxisLabels[Int(value) % xAxisLabels.count]
    }
}
