//
//  OnboardingSlideProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

protocol OnboardingSlideProtocol: UICollectionViewCell {
    func appearing()
//    func disappearing()
    func configure(model: OnboardingViewModelProtocol)
}
