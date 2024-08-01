//
//  UIView+SetGradient.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 28.07.2024.
//

import Foundation
import UIKit

extension UIView {
    func applyGradient(colors: [CGColor] = [UIColor(red: 0.99, green: 0.0, blue: 0.93, alpha: 1.00).cgColor,
                                            UIColor(red: 0.73, green: 0.0, blue: 0.27, alpha: 1.00).cgColor],
                       startPoint: CGPoint = CGPoint(x: 0, y: 0.5),
                       endPoint: CGPoint = CGPoint(x: 1, y: 0.5),
                       cornerRadius: CGFloat = 0) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds
        gradientLayer.cornerRadius = cornerRadius
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func updateGradientFrame() {
        if let gradientLayer = layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }
}
