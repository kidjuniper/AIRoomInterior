//
//  UIStackView+RemoveArrangedSubviews.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation
import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        for i in subviews {
            i.removeFromSuperview()
        }
    }
}
