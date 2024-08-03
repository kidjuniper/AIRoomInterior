//
//  OnboardingViewOutputProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation

protocol OnboardingViewOutputProtocol {
    func nextScreenButtonTapped(currentPage: Int)
    func privacyPolicyTapped()
    func restorePurchaseTapped()
    func termsOfUseTapped()
}
