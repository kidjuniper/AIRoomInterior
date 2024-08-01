//
//  NeccessaryInAppButtonsView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 01.08.2024.
//

import Foundation
import UIKit

class NeccessaryInAppButtonsView: UIView {
    var delegate: NeccessaryInAppButtonsViewDelegate?
    
    // MARK: - UI elements
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    let privacyPolicyButton: UIButton = {
        let button = UIButton()
        button.setLightTitle("Privacy policy",
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        return button
    }()
    
    let restorePurchaseButton: UIButton = {
        let button = UIButton()
        button.setLightTitle("Restore Purchase",
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
        return button
    }()
    
    let termsOfUseButton: UIButton = {
        let button = UIButton()
        button.setLightTitle("Terms of Use",
                        for: .normal)
        button.setTitleColor(.white,
                             for: .normal)
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
        setUpStack()
        setUpLayout()
        setUpTargets()
    }
    
    // MARK: - Appearance
    private func setUpLayout() {
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stack.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                   constant: 5),
                                     stack.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                    constant: -5),
                                     stack.topAnchor.constraint(equalTo: topAnchor),
                                     stack.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
    
    private func setUpStack() {
        stack.addArrangedSubviews(privacyPolicyButton,
                                  restorePurchaseButton,
                                  termsOfUseButton)
    }
    
    // MARK: - Actions
    private func setUpTargets() {
        privacyPolicyButton.addTarget(self,
                                      action: #selector(privacyPolicyTapped),
                                      for: .touchUpInside)
        restorePurchaseButton.addTarget(self,
                                        action: #selector(restorePurchaseTapped),
                                        for: .touchUpInside)
        termsOfUseButton.addTarget(self,
                                   action: #selector(termsOfUseTapped),
                                   for: .touchUpInside)
    }
    
    @objc func privacyPolicyTapped() {
        delegate?.privacyPolicyTapped()
    }
    
    @objc func restorePurchaseTapped() {
        delegate?.restorePurchaseTapped()
    }
    
    @objc func termsOfUseTapped() {
        delegate?.termsOfUseTapped()
    }
}

protocol NeccessaryInAppButtonsViewDelegate {
    func privacyPolicyTapped()
    func restorePurchaseTapped()
    func termsOfUseTapped()
}
