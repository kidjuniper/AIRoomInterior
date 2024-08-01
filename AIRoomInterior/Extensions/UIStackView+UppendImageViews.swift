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
    
    func uppendTitlelabels(withTitles titles: [String]) {
        for i in titles {
            let label = UILabel()
            label.text = i
            label.textAlignment = .center
            label.font = UIFont(name: K.regularFontName,
                                size: 12)
            label.textColor = .white
            addArrangedSubview(label)
        }
    }
}
