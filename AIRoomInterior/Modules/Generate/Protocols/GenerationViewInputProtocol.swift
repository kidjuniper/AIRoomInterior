//
//  GenerationViewInputProtocol.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

protocol GenerationViewInputProtocol: UIViewController,
                                        UIImagePickerControllerDelegate,
                                      UINavigationControllerDelegate  {
    func updateChoice()
    func updateImageSelection(withImage image: UIImage)
    func updateMode(mode: InputMode)
    func showImageSelector()
    func showLoading()
    func showResult(image: UIImage)
    func showImageProcessing()
    func showEndOfImageProcessing(withImage image: UIImage)
}
