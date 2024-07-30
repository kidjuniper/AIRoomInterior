//
//  Alle.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func showSlides(_ slides: [OnboardingSlide])
}

protocol OnboardingPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didTapNext()
    func didTapPrevious()
    func didTapSkip()
}
