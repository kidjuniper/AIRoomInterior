//
//  GenerationViewOutputProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 23.07.2024.
//

import Foundation
import UIKit

protocol GenerationViewOutputProtocol {
    func selectedStyle(styleId id: Int)
    func selectedRoom(roomId id: Int)
    func selectedMode(mode: InputMode)
    func settedDescription(text: String)
    func selectedImage(image: UIImage)
    func tappedImageSelection()
    func generationPressed()
}
