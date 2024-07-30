//
//  OnboardingPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation

class OnboardingPresenter: OnboardingPresenterProtocol {
    weak var view: OnboardingViewProtocol?
    private var slides: [OnboardingSlide] = []
    private var currentIndex = 0
    
    func viewDidLoad() {
        slides = [
            OnboardingSlide(title: "Welcome to AI Interior Design", description: "Instantly redesign your home with AI", imageName: "onboarding1"),
            OnboardingSlide(title: "Take a photo of your room", description: "Choose a style to design your room", imageName: "onboarding2"),
            OnboardingSlide(title: "One tap, infinite designs", description: "Get instant, detailed, and accurate interior design options", imageName: "onboarding3")
        ]
        view?.showSlides(slides)
    }
    
    func didTapNext() {
        if currentIndex < slides.count - 1 {
            currentIndex += 1
            view?.showSlides([slides[currentIndex]])
        }
    }
    
    func didTapPrevious() {
        if currentIndex > 0 {
            currentIndex -= 1
            view?.showSlides([slides[currentIndex]])
        }
    }
    
    func didTapSkip() {
        // Handle skip logic
    }
}
