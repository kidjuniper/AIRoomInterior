//
//  OnboardingLinesCollectionViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation
import UIKit

class OnboardingLinesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    
    private let topImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let midImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let bottomImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 23)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private var labelStackView = UIStackView()
    
    private var firstCenterStackImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Animated Constraints
    
    private var topStackCenterXConstraint: NSLayoutConstraint?
    
    private var midStackCenterXConstraint: NSLayoutConstraint?
    
    private var bottomStackCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Properties
    static let cellId = "OnboardingLinesCollectionViewCell"
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

// MARK: - Appearance
private extension OnboardingLinesCollectionViewCell {
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "Black")
        labelStackView = .init(arrangedSubviews: [titleLabel,
                                                  textLabel],
                               axis: .vertical,
                               spacing: 20)
        
        contentView.addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                            constant: -(UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 ? 90 : 140)),
                                     labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                             constant: 20),
                                     labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                              constant: -20)
        ])
        
        contentView.addSubview(bottomImagesStack)
        bottomImagesStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStackCenterXConstraint = bottomImagesStack.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                                                  constant: 120)
        
        NSLayoutConstraint.activate([bottomImagesStack.bottomAnchor.constraint(equalTo: labelStackView.topAnchor,
                                                                               constant: -(UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 ? 20 : 80)),
                                     bottomStackCenterXConstraint!,
                                     bottomImagesStack.widthAnchor.constraint(equalTo: widthAnchor,
                                                                              multiplier: 1.05),
                                     bottomImagesStack.heightAnchor.constraint(equalToConstant: 90)])
        
        contentView.addSubview(midImagesStack)
        midImagesStack.translatesAutoresizingMaskIntoConstraints = false
        midStackCenterXConstraint = midImagesStack.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                                            constant: -120)
        
        NSLayoutConstraint.activate([midImagesStack.bottomAnchor.constraint(equalTo: bottomImagesStack.topAnchor,
                                                                            constant: -UIScreen.main.bounds.height * 0.025),
                                     midStackCenterXConstraint!,
                                     midImagesStack.widthAnchor.constraint(equalTo: widthAnchor,
                                                                           multiplier: 1.34),
                                     midImagesStack.heightAnchor.constraint(equalToConstant: 90)])
        
        contentView.addSubview(topImagesStack)
        topImagesStack.translatesAutoresizingMaskIntoConstraints = false
        midImagesStack.translatesAutoresizingMaskIntoConstraints = false
        topStackCenterXConstraint = topImagesStack.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                                            constant: 120)
        
        NSLayoutConstraint.activate([topImagesStack.bottomAnchor.constraint(equalTo: midImagesStack.topAnchor,
                                                                            constant: -UIScreen.main.bounds.height * 0.025),
                                     topStackCenterXConstraint!,
                                     topImagesStack.widthAnchor.constraint(equalTo: widthAnchor,
                                                                           multiplier: 1.05),
                                     topImagesStack.heightAnchor.constraint(equalToConstant: 90)])
        
    }
    
    private func setUpStacks(withImages images: [UIImage]) {
        if images.count > 9 {
            [topImagesStack,
             midImagesStack,
             bottomImagesStack].forEach { stack in
                stack.removeArrangedSubviews()
            }
            topImagesStack.uppendImageViews(images: Array(images[0...2]))
            firstCenterStackImage.image = images[3] // для лучшей анимации появления выносим для управления прозрачностью
            midImagesStack.addArrangedSubview(firstCenterStackImage)
            midImagesStack.uppendImageViews(images: Array(images[4...6]))
            bottomImagesStack.uppendImageViews(images: Array(images[7...9]))
        }
        else {
            print("Not enought images setted to setUp OnboardingLinesCollectionViewCell")
        }
    }
}

// MARK: - OnboardingSlideProtocol
extension OnboardingLinesCollectionViewCell: OnboardingSlideProtocol {
    public func configure(model: OnboardingViewModelProtocol) {
        [self.topImagesStack,
         self.midImagesStack,
         self.bottomImagesStack].forEach { view in
            view.layer.opacity = 0
        }
        setUpStacks(withImages: model.secondaryImages)
        titleLabel.text = model.title
        textLabel.text = model.text
    }
    
    public func appearing() {
        DispatchQueue.main.async {
            [self.topImagesStack,
             self.midImagesStack,
             self.bottomImagesStack].forEach { view in
                UIView.animate(withDuration: 0.8) {
                    view.layer.opacity = 1
                }
            }
            
            // чтобы не перекрывать соседнюю ячейку
            self.firstCenterStackImage.layer.opacity = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.firstCenterStackImage.layer.opacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.clipsToBounds = true
            }
            
            [self.topStackCenterXConstraint,
             self.midStackCenterXConstraint,
             self.bottomStackCenterXConstraint].forEach { constraint in
                UIView.animate(withDuration: 1.5) {
                    constraint?.constant = 0
                    self.contentView.layoutIfNeeded()
                }
            }
        }
    }
    
//    public func disappearing() {
//        DispatchQueue.main.async {
//            [self.topImagesStack,
//             self.midImagesStack,
//             self.bottomImagesStack].forEach { view in
//                UIView.animate(withDuration: 1.5) {
//                    view.layer.opacity = 0
//                }
//            }
//            UIView.animate(withDuration: 1.5) {
//                [self.topStackCenterXConstraint,
//                 self.bottomStackCenterXConstraint].forEach { constraint in
//                    constraint?.constant = 120
//                }
//                self.midStackCenterXConstraint?.constant = -120
//                self.contentView.layoutIfNeeded()
//            }
//            self.clipsToBounds = false
//        }
//    }
}
