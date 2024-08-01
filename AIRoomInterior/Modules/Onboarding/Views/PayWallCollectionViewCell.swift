//
//  PayWallCollectionViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 31.07.2024.
//

import Foundation
import UIKit

class PayWallCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private let payWallView = PayWallView()
    
    // MARK: - Properties
    static let cellId = "PayWallCollectionViewCell"
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Appearance
private extension PayWallCollectionViewCell {
    private func setUpUI() {
        contentView.addSubview(payWallView)
        payWallView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([payWallView.topAnchor.constraint(equalTo: topAnchor),
                                     payWallView.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     payWallView.trailingAnchor.constraint(equalTo: trailingAnchor),
                                     payWallView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}

// MARK: - OnboardingSlideProtocol
extension PayWallCollectionViewCell: OnboardingSlideProtocol {
    public func configure(model: OnboardingViewModelProtocol) {
        payWallView.configure(model: model)
    }
    
    public func appearing() {
        payWallView.appearing()
    }
    
    public func disappearing() {
        payWallView.disappearing()
    }
}
