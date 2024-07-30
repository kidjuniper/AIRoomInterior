//
//  ResultViewProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 27.07.2024.
//

import Foundation
import UIKit

protocol ResultViewDelegate {
    func closeTapped()
    func saveImage(image: UIImage)
}

protocol ResultViewProtocol: UIView {
    func imageSaved()
    func setDelegate(delegate: ResultViewDelegate)
    func setImage(image: UIImage)
}
