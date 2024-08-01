//
//  TopLineView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 28.07.2024.
//

import Foundation
import UIKit

final class TopLineView: UIView {
    
    var delegate: TopLineViewDelegate?
    
    // MARK: -  UI components
    let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "threeLines"),
                        for: .normal)
        return button
    }()
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.text = "Archie"
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName,
                            size: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    let subscriptionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pro",
                        for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 10,
                                              bottom: 0,
                                              right: 10)
        button.titleLabel?.textAlignment = .right
        button.setTitleColor(.systemPink,
                             for: .normal)
        button.tintColor = .systemPink
        
        button.setImage(UIImage(systemName: "bolt.fill"),
                        for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 3,
                                              left: 0,
                                              bottom: 5,
                                              right: 5)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemPink.cgColor
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Final SetUp
    private func setUp() {
        setUpTargets()
        setUpLayouts()
    }
    
    // MARK: - Appearance
    private func setUpLayouts() {
        addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([settingsButton.widthAnchor.constraint(equalToConstant: 24),
                                     settingsButton.heightAnchor.constraint(equalToConstant: 24),
                                     settingsButton.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     settingsButton.centerYAnchor.constraint(equalTo: centerYAnchor)])
        
        addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     topLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     topLabel.topAnchor.constraint(equalTo: topAnchor),
                                     topLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
        addSubview(subscriptionButton)
        subscriptionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([subscriptionButton.widthAnchor.constraint(equalToConstant: 68),
                                     subscriptionButton.heightAnchor.constraint(equalToConstant: 28),
                                     subscriptionButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     subscriptionButton.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    
    
    // MARK: - Actions
    @objc func settingsButtonPressed() {
        delegate?.settingsButtonPressed()
    }
    
    @objc func subscriptionButtonPressed() {
        delegate?.subscriptionButtonPressed()
    }
    
    private func setUpTargets() {
        subscriptionButton.addTarget(self,
                            action: #selector(subscriptionButtonPressed),
                                     for: .touchUpInside)
        
        settingsButton.addTarget(self,
                            action: #selector(settingsButtonPressed),
                                     for: .touchUpInside)
    }
}
