//
//  UIView+AddBlur.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 27.07.2024.
//

import Foundation
import UIKit

extension UIView {
    func addBlur() {
        let blurEffectView = UIVisualEffectView(effect: nil)
        
        blurEffectView.frame = self.bounds
        blurEffectView.tag = 1111
        blurEffectView.autoresizingMask = [.flexibleWidth,
                                           .flexibleHeight]
        UIView.animate(withDuration: 0.7) {
            blurEffectView.effect = UIBlurEffect(style: .systemChromeMaterialDark)
        }
        
        self.addSubview(blurEffectView)
    }
    
    
    func removeBlur() {
        UIView.animate(withDuration: 0.3) {
            self.viewWithTag(1111)?.layer.opacity = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.viewWithTag(1111)?.removeFromSuperview()
        }
    }
}
