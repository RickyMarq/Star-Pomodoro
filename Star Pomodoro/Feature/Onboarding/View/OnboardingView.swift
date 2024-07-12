//
//  OnboardingView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 19/09/23.
//

import UIKit

protocol OnboardingViewProtocol: AnyObject {
    func skipIntroButton()
}

class OnboardingView: UIView {
    
    weak var delegate: OnboardingViewProtocol?
    
    func delegate(delegate: OnboardingViewProtocol) {
        self.delegate = delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSizeMake(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.indicatorStyle = .default
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return collectionView
    }()
    
    func onboardingCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.onboardingCollectionView.delegate = delegate
        self.onboardingCollectionView.dataSource = dataSource
    }
    
    lazy var onboardingViewPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemYellow
        pageControl.pageIndicatorTintColor = .gray
        pageControl.isUserInteractionEnabled = false
        pageControl.isAccessibilityElement = false
        pageControl.tag = 1
        pageControl.layer.masksToBounds = true
        pageControl.layer.cornerRadius = 10
        return pageControl
    }()
    
    lazy var skipIntroButton: UIButton = {
        let button = UIButton()
        button.setTitle("Próximo", for: .normal)
        button.setButtonStyling(layout: .normal)
        button.addTarget(self, action: #selector(skipIntroButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func skipIntroButtonTapped() {
        self.delegate?.skipIntroButton()
    }
}

extension OnboardingView: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.onboardingCollectionView)
        self.addSubview(self.onboardingViewPageControl)
        self.addSubview(self.skipIntroButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.onboardingCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.onboardingCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onboardingCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onboardingCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.onboardingViewPageControl.topAnchor.constraint(equalTo: self.onboardingCollectionView.bottomAnchor, constant: -120),
            self.onboardingViewPageControl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.onboardingViewPageControl.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.onboardingViewPageControl.heightAnchor.constraint(equalToConstant: 50),
            
            self.skipIntroButton.topAnchor.constraint(equalTo: self.onboardingViewPageControl.topAnchor, constant: -44),
            self.skipIntroButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 100),
            self.skipIntroButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -100),
            self.skipIntroButton.heightAnchor.constraint(equalToConstant: 44),
            
        ])
    }
    
    func configureAdditionalBehaviors() { }
    
    func configureAccessibility() { }
}
