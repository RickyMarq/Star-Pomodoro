//
//  OnboardingCell.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import UIKit
import Lottie

class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    var onboardingViewModel: OnboardingCellViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var backgroundContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemYellow.withAlphaComponent(0.3)
        return view
    }()
    
    lazy var onBoardingAnimationView: LottieAnimationView = {
        var animationView = LottieAnimationView()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.contentMode = .scaleToFill
        animationView.tintColor = .systemPurple
        animationView.play()
        return animationView
    }()

    lazy var onboardingPrimaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    lazy var onboardingSecondaryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    func setUpCell(data: OnboardingDataModel) {
        onboardingViewModel = OnboardingCellViewModel(objc: data)
        self.onboardingPrimaryLabel.text = onboardingViewModel?.primaryLabel
        self.onboardingSecondaryLabel.text = onboardingViewModel?.secondaryLabel
        self.onBoardingAnimationView.animation = .named(onboardingViewModel?.imageString ?? "")
        self.onBoardingAnimationView.play()
    }
}

extension OnboardingCell: ViewCode {
    
    func configureSubViews() {
        self.contentView.addSubview(self.backgroundContentView)
        self.contentView.addSubview(self.onBoardingAnimationView)
        self.contentView.addSubview(self.onboardingPrimaryLabel)
        self.contentView.addSubview(self.onboardingSecondaryLabel)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            
            self.backgroundContentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundContentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundContentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundContentView.bottomAnchor.constraint(equalTo: self.onboardingPrimaryLabel.topAnchor, constant: -12),
            
            self.onBoardingAnimationView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            self.onBoardingAnimationView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.onBoardingAnimationView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.onBoardingAnimationView.heightAnchor.constraint(equalToConstant: 250),
            
            self.onboardingPrimaryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.onboardingPrimaryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.onboardingPrimaryLabel.topAnchor.constraint(equalTo: self.onBoardingAnimationView.bottomAnchor, constant: 50),
            
            self.onboardingSecondaryLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.onboardingSecondaryLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            self.onboardingSecondaryLabel.topAnchor.constraint(equalTo: self.onboardingPrimaryLabel.bottomAnchor, constant: 12),
            
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .secondarySystemBackground
    }
    
    func configureAccessibility() { }
}

