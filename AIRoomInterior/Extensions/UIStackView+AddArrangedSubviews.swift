//
//  UIStackView+AddArrangedSubviews.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 26.07.2024.
//

import Foundation
import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
        self.distribution = .equalSpacing
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
            sendSubviewToBack($0)
        }
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach {
            addArrangedSubview($0)
            sendSubviewToBack($0)
        }
    }
}
