//
//  OnboardingCrossCollectionView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

class OnboardingCrossCollectionView: UICollectionViewCell {
    
    // MARK: - SubViews
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let examplesView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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

// MARK: - Setups
private extension OnboardingCrossCollectionView {
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
                                              constant: -120),
            mainImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 228),
            mainImageView.heightAnchor.constraint(equalToConstant: 350),
            
            labelStackView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,
                                               constant: 30),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                    constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -20)
        ])
        
        addSubview(leftImageView)
        leftImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leftImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
                                     leftImageView.heightAnchor.constraint(equalToConstant: 287),
                                     leftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                                     leftImageView.trailingAnchor.constraint(equalTo: mainImageView.leadingAnchor,
                                                                            constant: -25)
                                    ])
        
        addSubview(rightImageView)
        rightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([rightImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
                                     rightImageView.heightAnchor.constraint(equalToConstant: 287),
                                     rightImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                                     rightImageView.leadingAnchor.constraint(equalTo: mainImageView.trailingAnchor,
                                                                            constant: 25)
                                    ])
    }
}

// MARK: - Public
extension OnboardingCrossCollectionView: OnboardingSlideProtocol {
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
                UIView.animate(withDuration: 1.5) {
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
                UIView.animate(withDuration: 1) {
                    view.layer.opacity = 0
                }
            }
        }
    }
}
