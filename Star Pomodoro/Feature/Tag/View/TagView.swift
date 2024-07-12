//
//  TagView.swift
//  Star Pomodoro
//
//  Created by Henrique Marques on 20/09/23.
//

import UIKit
import TagListView

protocol tagScreenProtocol: AnyObject {
    func addNewTagAction()
}

class tagScreen: UIView {
    
    weak var delegate: tagScreenProtocol?
    
    func delegate(delegate: tagScreenProtocol) {
        self.delegate = delegate
    }
    
    lazy var tagList: TagListView = {
        let tagList = TagListView()
        tagList.translatesAutoresizingMaskIntoConstraints = false
        tagList.textFont = UIFont.systemFont(ofSize: 24, weight: .thin)
        tagList.alignment = .leading
        tagList.tagBackgroundColor = .secondarySystemBackground
        tagList.enableRemoveButton = true
        tagList.cornerRadius = 12
        tagList.shadowColor = UIColor.red
        tagList.shadowOffset = CGSize(width: 1, height: 1)
        tagList.paddingX = 8
        tagList.paddingY = 8
        tagList.marginY = 12
        tagList.marginX = 12
        tagList.shadowColor = .systemBackground
        tagList.textColor = .secondaryLabel
        tagList.removeIconLineColor = .darkGray
        tagList.tagSelectedBackgroundColor = .systemYellow.withAlphaComponent(0.5)
        return tagList
    }()
    
    lazy var tagScreenScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceHorizontal = true
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .tertiarySystemBackground
        return view
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    func tagListDelegate(delegate: TagListViewDelegate) {
        self.tagList.delegate = delegate
    }
    
    lazy var addNewTagButton: UIButton = {
        let button = UIButton()
        button.setButtonStyling(layout: .normal)
        button.setTitle("+", for: .normal)
        button.addTarget(self, action: #selector(addNewTagButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func addNewTagButtonTapped() {
        self.delegate?.addNewTagAction()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension tagScreen: ViewCode {
    
    func configureSubViews() {
        self.addSubview(self.tagScreenScrollView)
        self.tagScreenScrollView.addSubview(self.contentView)
        self.contentView.addSubview(self.horizontalStackView)
        self.horizontalStackView.addArrangedSubview(self.addNewTagButton)
        self.horizontalStackView.addArrangedSubview(self.tagList)
//        self.addSubview(self.addNewTagButton)
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            
            self.tagScreenScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            self.tagScreenScrollView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 24),
            self.tagScreenScrollView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -24),
//            self.tagScreenScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            self.tagScreenScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            self.contentView.topAnchor.constraint(equalTo: self.tagScreenScrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.tagScreenScrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.tagScreenScrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.tagScreenScrollView.bottomAnchor),
 //           self.tagScreenScrollView.heightAnchor.constraint(equalToConstant: 100),
            self.contentView.heightAnchor.constraint(equalToConstant: 40),
            self.contentView.widthAnchor.constraint(equalToConstant: 3000),
        
            
            self.horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            self.horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            self.horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            self.horizontalStackView.heightAnchor.constraint(equalToConstant: 48),
            // Set a fixed height for the stack view

            
            self.addNewTagButton.widthAnchor.constraint(equalToConstant: 44),
//            self.addNewTagButton.heightAnchor.constraint(equalToConstant: 1),
//            self.addNewTagButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 12),
//            self.addNewTagButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
//            self.addNewTagButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50),
        
        ])
    }
    
    func configureAdditionalBehaviors() {
        self.backgroundColor = .tertiarySystemBackground
    }
    
    func configureAccessibility() { }
    
}
