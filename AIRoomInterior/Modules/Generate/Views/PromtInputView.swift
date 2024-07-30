//
//  PromtInputView.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 25.07.2024.
//

import Foundation
import UIKit

class PromtInputView: UIView {
    
    // MARK: - UI elements
    private let modeSelector: CircledSegmentedControl = {
        let segmented = CircledSegmentedControl()
        
        segmented.insertSegment(withTitle: "Text",
                                at: 0,
                                animated: false)
        segmented.insertSegment(withTitle: "Photo",
                                at: 1,
                                animated: false)
        segmented.selectedSegmentIndex = 0
        
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black,
                                          NSAttributedString.Key.font: UIFont(name: K.boldFontName,
                                                                              size: 15)!],
                                         for: .selected)
        segmented.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white,
                                          NSAttributedString.Key.font: UIFont(name: K.boldFontName,
                                                                              size: 15)!],
                                         for: .normal)
        
        segmented.selectedSegmentTintColor = .white.withAlphaComponent(0.5)
        segmented.tintColor = .white
        segmented.layer.cornerRadius = 50
        segmented.layer.masksToBounds = true
        
        return segmented
    }()
    
    private let descriptionTextFiled: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 15
        textView.clipsToBounds = true
        textView.backgroundColor = .clear
        textView.layer.borderWidth = 2
        textView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        textView.isScrollEnabled = false
        textView.font = UIFont(name: K.regularFontName,
                               size: 15)
        textView.text = "Describe the interior (e.g., a modern living room with large windows and soft furniture)..."
        textView.textContainerInset = UIEdgeInsets(top: 15,
                                                   left: 10,
                                                   bottom: 15,
                                                   right: 10)
        textView.textColor = .darkGray
        textView.textAlignment = .left
        
        return textView
    }()
    
    private let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Select Photo", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)

        let image = UIImage(systemName: "arrow.up")
        button.setImage(image, for: .normal)
        button.tintColor = .white

        button.imageEdgeInsets = UIEdgeInsets(top: -10,
                                              left: 0,
                                              bottom: 0,
                                              right: -90)
        button.titleEdgeInsets = UIEdgeInsets(top: 40,
                                              left: -image!.size.width,
                                              bottom: 0,
                                              right: 0)

        button.backgroundColor = .black
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(selectPhotoButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private let processingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        return indicator
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    // MARK: - properties
    
    var delegate: PromtInputViewDelegate? {
        didSet {
            descriptionTextFiled.delegate = delegate
        }
    }
    
    private var selectedMode: InputMode = .text
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Final SetUp
    
    private func setUp() {
        setUpAppearance()
        setUpTargets()
    }
    
    //  MARK: - Appearance
    private func setUpLayout() {
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stack.topAnchor.constraint(equalTo: topAnchor),
                                     stack.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     stack.leadingAnchor.constraint(equalTo: leadingAnchor),
                                     stack.trailingAnchor.constraint(equalTo: trailingAnchor)])
        stack.addArrangedSubviews(modeSelector,
                                  descriptionTextFiled)
        
        modeSelector.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        descriptionTextFiled.heightAnchor.constraint(equalToConstant: 107).isActive = true
        
        selectPhotoButton.heightAnchor.constraint(equalToConstant: 107).isActive = true
    }
    
    private func setUpAppearance() {
        setUpLayout()
        modeSelector.applyGradient()
    }
    
    //  MARK: - Actions
    private func setUpTargets() {
        modeSelector.addTarget(self,
                               action: #selector(update),
                               for: .valueChanged)
    }
    
    @objc func update() {
        switch modeSelector.selectedSegmentIndex {
        case 0:
            selectPhotoButton.removeFromSuperview()
            stack.addArrangedSubview(descriptionTextFiled)
            delegate?.selectMode(mode: .text)
        default:
            descriptionTextFiled.removeFromSuperview()
            stack.addArrangedSubview(selectPhotoButton)
            delegate?.selectMode(mode: .photo)
        }
    }
    
    @objc private func selectPhotoButtonTapped() {
        delegate?.presentImagePicker()
    }
}

//  MARK: - PromtInputViewProtocol
extension PromtInputView: PromtInputViewProtocol {
    func viewDidLayoutSubviews() {
        modeSelector.updateGradientFrame()
        selectPhotoButton.addDashedBorder()
    }
    
    func showProcessingActivity() {
        addSubview(processingIndicator)
        processingIndicator.translatesAutoresizingMaskIntoConstraints = false
        processingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        processingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor,
                                                     constant: 25).isActive = true
    }
    
    func imageSetted(image: UIImage) {
        selectPhotoButton.setImage(image,
                                   for: .normal)
        processingIndicator.removeFromSuperview()
    }
    
    func returnDescription() -> InputResult {
        switch selectedMode {
        case .photo:
            return InputResult.image(UIImage(named: "background")!)
        case .text:
            return InputResult.description(descriptionTextFiled.text ?? "")
        }
    }
}
