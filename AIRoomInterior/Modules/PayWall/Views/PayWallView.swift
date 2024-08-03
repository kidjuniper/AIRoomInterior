//
//  PayWallView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 31.07.2024.
//

import Foundation
import UIKit

final class PayWallView: UIView {
    // MARK: - SubViews
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let bottomImagesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let subtitlesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
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
    
    // MARK: - Animated Constraint
    private var bottomStackCenterXConstraint: NSLayoutConstraint?
    private var subtitlesStackCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - Properties
    static let cellId = "PayWallCollectionViewCell"
    
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
private extension PayWallView {
    func setupUI() {
        backgroundColor = UIColor(named: "Black")
        labelStackView = .init(arrangedSubviews: [titleLabel,
                                                  textLabel],
                               axis: .vertical,
                               spacing: 20)
        
        addSubview(labelStackView)
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                            constant: -30),
                                     labelStackView.heightAnchor.constraint(equalToConstant: 100),
                                     labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                             constant: 20),
                                     labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                              constant: -20)
        ])
        
        addSubview(bottomImagesStack)
        bottomImagesStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStackCenterXConstraint = bottomImagesStack.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                                                 constant: 120)
        
        NSLayoutConstraint.activate([bottomImagesStack.bottomAnchor.constraint(equalTo: labelStackView.topAnchor,
                                                                               constant: -(UIScreen.main.bounds.height / UIScreen.main.bounds.width < 2 ? 50 : 80)),
                                     bottomStackCenterXConstraint!,
                                     bottomImagesStack.widthAnchor.constraint(equalTo: widthAnchor,
                                                                              multiplier: 1.3),
                                     bottomImagesStack.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        addSubview(subtitlesStack)
        subtitlesStack.translatesAutoresizingMaskIntoConstraints = false
        subtitlesStackCenterXConstraint = subtitlesStack.centerXAnchor.constraint(equalTo: centerXAnchor,
                                                                                     constant: 120)
        
        NSLayoutConstraint.activate([subtitlesStack.topAnchor.constraint(equalTo: bottomImagesStack.bottomAnchor),
                                     subtitlesStack.widthAnchor.constraint(equalTo: widthAnchor,
                                                                           multiplier: 1.3),
                                     subtitlesStackCenterXConstraint!])
        
        addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([mainImageView.bottomAnchor.constraint(equalTo: bottomImagesStack.topAnchor,
                                                                               constant: -20),
                                     mainImageView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                           constant: 12),
                                     mainImageView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                           constant: -12),
                                     mainImageView.topAnchor.constraint(equalTo: topAnchor,
                                                                       constant: 10)
        ])
    }
    
    private func setUpImagesStack(withImages images: [UIImage]) {
        if images.count > 4 {
            bottomImagesStack.removeArrangedSubviews()
            bottomImagesStack.uppendImageViews(images: Array(images[0...4]))
        }
        else {
            print("Not enought images setted to setUp OnboardingLinesCollectionViewCell")
        }
    }
    
    private func setUpSubtitlesStack(withTitles titles: [String]) {
        if titles.count > 4 {
            subtitlesStack.removeArrangedSubviews()
            subtitlesStack.uppendTitlelabels(withTitles: Array(titles[0...4]))
        }
        else {
            print("Not enought subtitles setted to setUp OnboardingLinesCollectionViewCell")
        }
    }
}

// MARK: - OnboardingSlideProtocol
extension PayWallView {
    public func configure(model: OnboardingViewModelProtocol) {
        bottomImagesStack.layer.opacity = 0
        setUpImagesStack(withImages: model.secondaryImages)
        setUpSubtitlesStack(withTitles: model.subTitles ?? [])
        titleLabel.text = model.title
        textLabel.text = model.text
        mainImageView.image = model.mainImage
    }
    
    public func appearing() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8) {
                self.bottomImagesStack.layer.opacity = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.clipsToBounds = true
            }
            UIView.animate(withDuration: 1.5) {
                self.bottomStackCenterXConstraint?.constant = 0
                self.subtitlesStackCenterXConstraint?.constant = 0
                self.layoutIfNeeded()
            }
        }
    }
}
