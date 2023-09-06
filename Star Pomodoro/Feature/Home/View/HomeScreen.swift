//
//  HomeScreen.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 02/08/23.
//

import UIKit
import HGCircularSlider
import Lottie

protocol HomeScreenProtocol: AnyObject {
    func startButtonAction()
    func giveUpButtonAction()
    func restButtonAction()
}

class HomeScreen: UIView {
    
    weak var delegate: HomeScreenProtocol?
    
    func delegate(delegate: HomeScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var launchAnimation: LottieAnimationView = {
        let animation = LottieAnimationView(name: "stars.json")
        animation.translatesAutoresizingMaskIntoConstraints = false
        animation.backgroundColor = .black
        animation.animationSpeed = 2.0
        animation.loopMode = .playOnce
        animation.contentMode = .scaleAspectFill
        return animation
    }()
    
    lazy var launchView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Let's get focused?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    lazy var actualSliderValue: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 42, weight: .bold)
        return label
    }()
    
    
    lazy var circularSliderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    lazy var circularSlider: CircularSlider = {
        let slider = CircularSlider(frame: circularSliderView.frame)
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.backgroundColor = .clear
//        slider.lineWidth = 15
        slider.minimumValue = 3
        slider.maximumValue = 120
        slider.endPointValue = 25.0
        slider.diskColor = .secondarySystemBackground
        slider.numberOfRounds = 1
        slider.trackColor = .darkGray
        slider.backtrackLineWidth = 10
        slider.endThumbTintColor = .darkGray
        slider.endThumbStrokeColor = .clear
        slider.stopThumbAtMinMax = true
        slider.trackFillColor = .systemYellow
        slider.endThumbStrokeHighlightedColor = .systemYellow
//        slider.diskFillColor = .systemGreen
//        slider.
        slider.addTarget(self, action: #selector(updateValues), for: .valueChanged)
        return slider
    }()
    
    lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("Begin", for: .normal)
        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var giveUpButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("Give Up", for: .normal)
        button.addTarget(self, action: #selector(giveUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var restButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("Rest", for: .normal)
        button.addTarget(self, action: #selector(restButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var phraseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        label.textColor = .secondaryLabel
        return label
    }()
    
    lazy var lottieAnimation: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        return animationView
    }()
    
    @objc func startButtonTapped() {
        self.delegate?.startButtonAction()
    }
    
    @objc func giveUpButtonTapped() {
        self.delegate?.giveUpButtonAction()
    }
    
    @objc func restButtonTapped() {
        self.delegate?.restButtonAction()
    }
    
    @objc func updateValues() {
        var value = circularSlider.endPointValue
        let roundedValue = round(value / 5.0) * 5.0
        if value != roundedValue {
                value = roundedValue
                circularSlider.endPointValue = value
            }
        let formatValue = String(format: "%.0f", value)
        self.actualSliderValue.text = formatValue + ":00"
        
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

extension HomeScreen: ViewCode {
  
    func configureSubViews() {
//        self.addSubview(self.containerImageBackground)
//       self.addSubview(self.launchView)
//        self.launchView.addSubview(self.launchAnimation)
//        self.addSubview(self.contentView)
        
        self.addSubview(self.primaryLabel)
        self.addSubview(self.circularSliderView)
        self.circularSliderView.addSubview(self.circularSlider)
//        self.circularSliderView.addSubview(self.lottieAnimation)
        self.addSubview(self.actualSliderValue)
        self.addSubview(self.buttonsStackView)
        self.addSubview(self.phraseLabel)
        self.buttonsStackView.addArrangedSubview(self.startButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
        
//            self.launchView.topAnchor.constraint(equalTo: self.topAnchor),
//            self.launchView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            self.launchView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.launchView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            
//            self.launchAnimation.topAnchor.constraint(equalTo: self.launchView.topAnchor, constant: 100),
//            self.launchAnimation.leadingAnchor.constraint(equalTo: self.launchView.leadingAnchor, constant: 100),
//            self.launchAnimation.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
//            self.launchAnimation.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100),
//                        
//            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
//            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.primaryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            self.primaryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.circularSliderView.topAnchor.constraint(equalTo: self.primaryLabel.bottomAnchor, constant: 20),
//            self.circularSliderView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.circularSliderView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            self.circularSliderView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            self.circularSliderView.heightAnchor.constraint(equalToConstant: 250),
            
            self.circularSlider.topAnchor.constraint(equalTo: self.circularSliderView.topAnchor),
            self.circularSlider.leadingAnchor.constraint(equalTo: self.circularSliderView.leadingAnchor),
            self.circularSlider.trailingAnchor.constraint(equalTo: self.circularSliderView.trailingAnchor),
            self.circularSlider.bottomAnchor.constraint(equalTo: self.circularSliderView.bottomAnchor),
            
//            self.lottieAnimation.leadingAnchor.constraint(equalTo: self.circularSlider.leadingAnchor, constant: 50),
//            self.lottieAnimation.trailingAnchor.constraint(equalTo: self.circularSlider.trailingAnchor, constant: -50),
//            self.lottieAnimation.topAnchor.constraint(equalTo: self.circularSlider.topAnchor, constant: 10),
//            self.lottieAnimation.bottomAnchor.constraint(equalTo: self.circularSlider.bottomAnchor, constant: -10),
            
//            self.lottieAnimation.topAnchor.constraint(equalTo: self.circularSliderView.topAnchor, constant: 16),
//            self.lottieAnimation.leadingAnchor.constraint(equalTo: self.circularSliderView.leadingAnchor, constant: 16),
//            self.lottieAnimation.trailingAnchor.constraint(equalTo: self.circularSliderView.trailingAnchor, constant: -16),
//            self.lottieAnimation.bottomAnchor.constraint(equalTo: self.circularSlider.bottomAnchor, constant: -10),
//            self.lottieAnimation.centerXAnchor.constraint(equalTo: self.circularSlider.centerXAnchor),
//            self.lottieAnimation.centerYAnchor.constraint(equalTo: self.circularSlider.centerYAnchor),
//            self.lottieAnimation.heightAnchor.constraint(equalToConstant: 100),
//            self.lottieAnimation.widthAnchor.constraint(equalToConstant: 100),
            
            self.actualSliderValue.topAnchor.constraint(equalTo: self.circularSliderView.bottomAnchor, constant: 20),
            self.actualSliderValue.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.phraseLabel.topAnchor.constraint(equalTo: self.actualSliderValue.bottomAnchor, constant: 44),
            self.phraseLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            self.phraseLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
            
            self.buttonsStackView.topAnchor.constraint(equalTo: self.phraseLabel.bottomAnchor, constant: 44),
            self.buttonsStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            self.buttonsStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
//            self.buttonsStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() {
        
    }
}
