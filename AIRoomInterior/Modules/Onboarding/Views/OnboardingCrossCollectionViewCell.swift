//
//  OnboardingCrossCollectionView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

class OnboardingCrossCollectionViewCell: UICollectionViewCell {
    
    // MARK: - SubViews
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.regularFontName,
                            size: 16)
        label.textColor = .white
        label.text = "Casual"
        return label
    }()
    
    private let examplesImageView: UIImageView = {
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
    static let cellId = "OnboardingCrossCollectionViewCell"
    
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
private extension OnboardingCrossCollectionViewCell {
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "Black")
        labelStackView = .init(arrangedSubviews: [titleLabel,
                                                  textLabel],
                               axis: .vertical,
                               spacing: 20)
        
        addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(examplesImageView)
        examplesImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                            constant: -(UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 ? 100 : 140)),
                                     labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                             constant: 20),
                                     labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                              constant: -20),
                                     
                                     examplesImageView.centerYAnchor.constraint(equalTo: mainImageView.centerYAnchor),
                                                                  examplesImageView.widthAnchor.constraint(equalTo: widthAnchor),
                                                                  examplesImageView.heightAnchor.constraint(equalToConstant: 140),
                                                                  examplesImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     
                                     subtitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     subtitleLabel.topAnchor.constraint(equalTo: examplesImageView.bottomAnchor),
                                     
                                     mainImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                                        constant: 5),
                                     mainImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     mainImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     mainImageView.widthAnchor.constraint(equalTo: mainImageView.heightAnchor,
                                                                          multiplier: 0.32)
        ])
    }
}

// MARK: - OnboardingSlideProtocol
extension OnboardingCrossCollectionViewCell: OnboardingSlideProtocol {
    public func configure(model: OnboardingViewModelProtocol) {
        [self.mainImageView,
         self.examplesImageView].forEach { view in
            view.layer.opacity = 0
        }
        mainImageView.image = model.mainImage
        examplesImageView.image = model.secondaryImages.first!
        titleLabel.text = model.title
        textLabel.text = model.text
    }
    
    public func appearing() {
        DispatchQueue.main.async {
            [self.mainImageView,
             self.examplesImageView].forEach { view in
                UIView.animate(withDuration: 1.5) {
                    view.layer.opacity = 1
                }
            }
        }
    }
    
//    public func disappearing() {
//        DispatchQueue.main.async {
//            [self.mainImageView,
//             self.examplesImageView].forEach { view in
//                UIView.animate(withDuration: 1.5) {
//                    view.layer.opacity = 0
//                }
//            }
//        }
//    }
}
