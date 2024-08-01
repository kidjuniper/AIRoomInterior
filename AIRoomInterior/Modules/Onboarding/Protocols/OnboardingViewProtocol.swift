//
//  OnboardingViewProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

protocol OnboardingViewInputProtocol: UIViewController {
    func dataSetted(withPageNumber number: Int) // ??? мб две функции сделать
    func showInAppAttributes()
    func scrollToNextScreen(indexPath: IndexPath)
}
