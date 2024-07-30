//
//  OnboaringPresenterProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

protocol OnboardingPresenterProtocol: UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout,
                                      OnboardingViewOutputProtocol{
    func viewDidLoad()
    func getNextVC()
}
