//
//  ResultView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 26.07.2024.
//

import Foundation
import UIKit

class ResultView: UIView {
    var delegate: ResultViewDelegate?
    
    // MARK: - UI elements
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.square"),
                        for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 5)
        button.setTitle("Close",
                        for: .normal)
        button.tintColor = .white
        button.titleLabel?.textColor = .white
        
        button.backgroundColor = .lightGray.withAlphaComponent(0.6)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.down"),
                        for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0,
                                              left: 0,
                                              bottom: 0,
                                              right: 5)
        button.tintColor = .white
        button.setTitle("Save",
                        for: .normal)
        button.titleLabel?.textColor = .white
        
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Final SetUp
    func setUp() {
        setUpAppearance()
        setUpTargets()
    }
    
    // MARK: - Appearance
    func setUpAppearance() {
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([closeButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                         constant: -25),
                                     closeButton.heightAnchor.constraint(equalToConstant: 40),
                                     closeButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                          constant: 18),
                                     closeButton.trailingAnchor.constraint(equalTo: centerXAnchor,
                                                                           constant: -5)])
        
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([saveButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                        constant: -25),
                                     saveButton.heightAnchor.constraint(equalToConstant: 40),
                                     saveButton.leadingAnchor.constraint(equalTo: centerXAnchor,
                                                                         constant: 5),
                                     saveButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                                          constant: -18)])
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.topAnchor.constraint(equalTo: topAnchor,
                                                                    constant: 25),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor,
                                                                      multiplier: 1.25),
                                     imageView.bottomAnchor.constraint(equalTo: closeButton.topAnchor,
                                                                       constant: -10)])
        
        
        
        
       
        
        backgroundColor = .white
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
    // MARK: - Actions
    func setUpTargets() {
        closeButton.addTarget(self,
                              action: #selector(closeTapped),
                              for: .touchUpInside)
        
        saveButton.addTarget(self,
                             action: #selector(saveImage),
                             for: .touchUpInside)
    }
    
    @objc func closeTapped() {
        delegate?.closeTapped()
    }
    
    @objc func saveImage() {
        if let image = imageView.image {
            delegate?.saveImage(image: image)
        }
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
}

// MARK: - ResultViewProtocol
extension ResultView: ResultViewProtocol {
    func setDelegate(delegate: any ResultViewDelegate) {
        self.delegate = delegate
    }
    
    func imageSaved() {
        DispatchQueue.main.async {
            self.saveButton.setTitle("Saved",
                                for: .normal)
            self.saveButton.setImage(UIImage(systemName: "checkmark.seal"),
                                for: .normal)
            self.saveButton.backgroundColor = .systemBlue
        }
    }
}
