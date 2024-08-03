//
//  UIButton+DashedBorder.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 28.07.2024.
//

import Foundation
import UIKit

extension UIButton {
    func addDashedBorder() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.strokeColor = UIColor.lightGray.cgColor
            shapeLayer.lineWidth = 1
            shapeLayer.lineDashPattern = [10, 10]
            shapeLayer.frame = bounds
            shapeLayer.fillColor = nil
            shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 15).cgPath
            layer.addSublayer(shapeLayer)
    }
}
