//
//  ModeButton.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 01.08.2024.
//

import Foundation
import UIKit

final class ModeButton: UIButton, ModeButtonProtocol {
    var isSelectedNow: Bool = true {
        didSet {
            if isSelectedNow {
                selected()
            }
            else {
                unselected()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.borderWidth = 2
        clipsToBounds = true
    }
    private func selected() {
        applyGradient()
        layer.borderColor = UIColor.clear.cgColor
    }
    
    private func unselected() {
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.removeFromSuperlayer()
        }
        layer.borderColor = UIColor.lightGray.cgColor
    }
}

protocol ModeButtonProtocol {
    var isSelectedNow: Bool { get }
}
