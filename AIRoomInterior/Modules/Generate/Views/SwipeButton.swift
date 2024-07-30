//
//  SwipeButton.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 23.07.2024.
//

import Foundation
import UIKit

class SwipeButton: UIControl {
    
    private let label = UILabel()
    private let swipeView = UIView()
    private let swipeIcon = UILabel()
    private var initialSwipeViewFrame: CGRect = .zero

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public func setup() {
        applyGradient()
        layer.cornerRadius = 30
        clipsToBounds = true

        label.text = "Generate ✨"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.frame = CGRect(x: 28, y: 0, width: UIScreen.main.bounds.width - 88, height: 60)
        addSubview(label)

        swipeView.backgroundColor = .white
        swipeView.layer.cornerRadius = 28
        swipeView.frame = CGRect(x: 2, y: 2, width: 56, height: 56)
        initialSwipeViewFrame = swipeView.frame
        addSubview(swipeView)
        
        swipeIcon.text = ">"
        swipeIcon.textColor = .systemPink
        swipeIcon.textAlignment = .center
        swipeIcon.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        swipeIcon.frame = swipeView.bounds
        swipeView.addSubview(swipeIcon)

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        swipeView.addGestureRecognizer(panGesture)
    }

    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)

        switch gesture.state {
        case .changed:
            var newCenterX = swipeView.center.x + translation.x
            newCenterX = max(swipeView.frame.width / 2, newCenterX)
            newCenterX = min(bounds.width - swipeView.frame.width / 2, newCenterX)
            swipeView.center.x = newCenterX
            label.layer.opacity = Float(1 - (newCenterX/bounds.width))
            gesture.setTranslation(.zero, in: self)

        case .ended:
            if swipeView.frame.maxX >= bounds.width - 10 {
                sendActions(for: .primaryActionTriggered)
                resetSwipeView()
            } else {
                resetSwipeView()
            }

        default:
            break
        }
    }

    private func resetSwipeView() {
        UIView.animate(withDuration: 0.3) {
            self.swipeView.frame = self.initialSwipeViewFrame
            self.label.layer.opacity = 1
        }
    }
}
