//
//  CustomPageControl.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 01.08.2024.
//

import Foundation
import UIKit

class CustomPageControl: UIView {

    var numberOfPages: Int = 0 {
        didSet {
            setupDots()
        }
    }

    var currentPage: Int = 0 {
        didSet {
            updateDots()
        }
    }

    private var dotViews: [UIView] = []

    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews = []

        for _ in 0..<numberOfPages {
            let dotView = UIView()
            dotView.backgroundColor = .gray
            dotView.layer.cornerRadius = 3
            addSubview(dotView)
            dotViews.append(dotView)
        }

        updateDots()
    }

    private func updateDots() {
        let dotSize: CGFloat = 6
        let selectedDotSize: CGFloat = 20
        let spacing: CGFloat = 8

        for (index, dotView) in dotViews.enumerated() {
            let size = index == currentPage ? selectedDotSize : dotSize
            dotView.frame = CGRect(x: CGFloat(index) * (dotSize + spacing), y: 0, width: size, height: dotSize)
            dotView.backgroundColor = index == currentPage ? .white : .gray
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDots()
    }
}
