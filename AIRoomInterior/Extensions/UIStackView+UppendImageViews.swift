//
//  UIStackView+uppendImageViews.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation
import UIKit

extension UIStackView {
    func uppendImageViews(images: [UIImage]) {
        for i in images {
            let imageView = UIImageView(image: i)
            imageView.layer.cornerRadius = 12
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            addArrangedSubview(imageView)
        }
    }
}
