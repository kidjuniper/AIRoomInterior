//
//  OnboardingTriptychCollectionViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

class OnboardingTriptychCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    // MARK: - Properties
    static let cellId = "OnboardingCollectionViewCell"
    
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
private extension OnboardingTriptychCollectionViewCell {
    func setupUI() {
        backgroundColor = .black
        labelStackView = .init(arrangedSubviews: [titleLabel,
                                                  textLabel],
                               axis: .vertical,
                               spacing: 20)
        addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mainImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor,
                                                                           constant: -80),
                                     mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     // используем множители для лучшей адаптации к разным девайсам
                                     mainImageView.widthAnchor.constraint(equalTo: widthAnchor,
                                                                          multiplier: 0.45),
                                     mainImageView.heightAnchor.constraint(equalTo: mainImageView.widthAnchor,
                                                                           multiplier: 2.5),
                                     
                                     labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                            constant: -(UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 ? 100 : 140)),
                                     labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                             constant: 20),
                                     labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                              constant: -20),
        ])
        
        addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leftImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
                                     leftImageView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor,
                                                                           multiplier: 0.55),
                                     leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     leftImageView.trailingAnchor.constraint(equalTo: mainImageView.leadingAnchor,
                                                                             constant: -25)
        ])
        
        addSubview(rightImageView)
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([rightImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
                                     rightImageView.heightAnchor.constraint(equalTo: mainImageView.heightAnchor,
                                                                            multiplier: 0.55),
                                     rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     rightImageView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor,
                                                                             constant: 25)
        ])
        
        contentView.layoutIfNeeded()
    }
}

// MARK: - OnboardingSlideProtocol
extension OnboardingTriptychCollectionViewCell: OnboardingSlideProtocol {
    public func configure(model: OnboardingViewModelProtocol) {
        [self.rightImageView,
         self.mainImageView,
         self.leftImageView].forEach { view in
            view.layer.opacity = 0
        }
        mainImageView.image = model.mainImage
        leftImageView.image = model.secondaryImages.first!
        rightImageView.image = model.secondaryImages.last!
        titleLabel.text = model.title
        textLabel.text = model.text
    }
    
    public func appearing() {
        DispatchQueue.main.async {
            [self.rightImageView,
             self.mainImageView,
             self.leftImageView].forEach { view in
                UIView.animate(withDuration: 0.7) {
                    view.layer.opacity = 1
                }
            }
        }
    }
    
    public func disappearing() {
        DispatchQueue.main.async {
            [self.rightImageView,
             self.mainImageView,
             self.leftImageView].forEach { view in
                UIView.animate(withDuration: 1.5) {
                    view.layer.opacity = 0
                }
            }
        }
    }
}
