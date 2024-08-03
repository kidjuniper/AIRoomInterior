//
//  CustomPageControl.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 01.08.2024.
//

import Foundation
import UIKit

class CustomPageControlContentView: UIView {

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
        let dotSize: CGFloat = 5
        let selectedDotSize: CGFloat = 50
        let spacing: CGFloat = 8

        for (index, dotView) in dotViews.enumerated() {
            let size = index == currentPage ? selectedDotSize : dotSize
            let leftInset = index > currentPage ? 0.0 : -50.0
            dotView.frame = CGRect(x: CGFloat(index) * (dotSize + spacing) + leftInset, y: 0, width: size, height: dotSize)
            dotView.backgroundColor = index == currentPage ? .white : .gray
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupDots()
    }
}

class CustomPageControl: UIView {
    let contentView = CustomPageControlContentView()
    
    var numberOfPages: Int = 0 {
        didSet {
            contentView.numberOfPages = numberOfPages
        }
    }

    var currentPage: Int = 0 {
        didSet {
            contentView.currentPage = currentPage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
