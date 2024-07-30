//
//  GenerationViewOutputProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 23.07.2024.
//

import Foundation
import UIKit

protocol GenerationViewOutputProtocol {
    func selectStyle(styleId id: Int)
    func selectRoom(roomId id: Int)
    func selectMode(mode: InputMode)
    func requestGeneration()
}

protocol GenerationViewInputProtocol: UIView {
    func updateChoice()
    func updateMode()
}
