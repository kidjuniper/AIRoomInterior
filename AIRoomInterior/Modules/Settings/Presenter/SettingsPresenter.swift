//
//  SettingsPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation
import UIKit

class SettingsPresenter: NSObject {
    weak var viewController: SettingsViewInputProtocol?
    
    // MARK: - Private Properties
    
    // MARK: - Initializer
    init(viewController: SettingsViewInputProtocol) {
        self.viewController = viewController
    }
}

