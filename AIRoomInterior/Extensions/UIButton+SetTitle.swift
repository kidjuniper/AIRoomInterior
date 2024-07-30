//
//  SetButton.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 25.07.2024.
//

import Foundation
import UIKit

extension UIButton {
    func setTitle(_ title: String?,
                  for state: UIControl.State) {
        let prettyString = NSAttributedString(string: title ?? "",
                                              attributes: [NSAttributedString.Key.font : UIFont(name: K.boldFontName,
                                                                                                size: 15)!])
        self.setAttributedTitle(prettyString, for: state)
    }
}
