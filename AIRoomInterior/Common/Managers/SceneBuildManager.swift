//
//  SceneBuildManager.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 23.07.2024.
//

import Foundation

protocol Buildable {
    func buildGenerateScreen() -> GenerationViewController
    func buildOnboardingScreen() -> OnboardingViewController
    func buildSettingsScreen() -> SettingsViewController
}

final class SceneBuildManager {
    
}

extension SceneBuildManager: Buildable {
    func buildSettingsScreen() -> SettingsViewController {
        let viewController = SettingsViewController()
        let presenter = SettingsPresenter(viewController: viewController)
        viewController.presenter = presenter
        return viewController
    }
    
    func buildOnboardingScreen() -> OnboardingViewController {
        let viewController = OnboardingViewController()
        var data: [OnboardingViewModelProtocol] = [OnboardingViewModel]()
        OnboardingViewModel.makeModel.forEach({ oneScreen in
            data.append(OnboardingViewModel(type: oneScreen.type,
                                             mainImage: oneScreen.mainImage,
                                             secondaryImages: oneScreen.secondaryImages,
                                             title: oneScreen.title,
                                             text: oneScreen.text))
        })
        let presenter = OnboardingPresenter(viewController: viewController,
                                            onboardingData: data,
                                            sceneBuildManager: self)
        viewController.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
    
    func buildGenerateScreen() -> GenerationViewController {
        let viewController = GenerationViewController()
        viewController.promtInputView = PromtInputView()
        let presenter = GeneratorPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.sceneBuildManager = self
        
        return viewController
    }
}
