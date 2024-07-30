//
//  PromtInputViewProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 27.07.2024.
//

import Foundation
import UIKit

protocol PromtInputViewProtocol: UIView {
    var delegate: PromtInputViewDelegate? { get set }
    
    func returnDescription() -> InputResult
    func showProcessingActivity()
    func imageSetted(image: UIImage)
    
    func viewDidLayoutSubviews()
}

protocol PromtInputViewDelegate: UITextViewDelegate {
    func selectMode(mode: InputMode)
    func presentImagePicker()
}
