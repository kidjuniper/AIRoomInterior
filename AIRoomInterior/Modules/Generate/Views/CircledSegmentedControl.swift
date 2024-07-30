//
//  CircledSegmentedController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 25.07.2024.
//

import Foundation
import UIKit

class CircledSegmentedControl: UISegmentedControl {
    private let segmentInset: CGFloat = 5
    private let segmentImage: UIImage? = UIImage(color: UIColor.white.withAlphaComponent(0.5))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex),
           let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset,
                                                                            dy: segmentInset)
            foregroundImageView.image = segmentImage
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}
