//
//  GenerationViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 26.07.2024.
//

import Foundation
import UIKit
import Photos

final class GenerationViewController: UIViewController {
    public var presenter: GeneratorPresenterProtocol? {
        didSet {
            styleCollectionView.dataSource = presenter
            styleCollectionView.delegate = self
            
            roomTypeCollectionView.dataSource = presenter
            roomTypeCollectionView.delegate = self
        }
    }
    
    // MARK: -  UI components
    private let topLineView = TopLineView() // заменить на протокол
     
    private let samplesStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        return stack
    }()
    
    private let instructionBigLabel: UILabel = {
        let label = UILabel()
        label.text = """
Use AI to generate many ideas
for your room
"""
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName,
                            size: 18)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let instructionSmallLabel: UILabel = {
        let label = UILabel()
        label.text = """
Please upload a photo of your room or describe
it in text.
"""
        label.numberOfLines = 0
        label.font = UIFont(name: K.regularFontName,
                            size: 12)
        label.textAlignment = .center
        label.textColor = .lightGray
        return label
    }()
    
    var promtInputView: PromtInputViewProtocol! {
        didSet {
            promtInputView.delegate = self
        }
    }
    
    private let selectRoomLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Room"
        label.numberOfLines = 0
        label.font = UIFont(name: K.regularFontName,
                            size: 21)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private static let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5,
                                           left: 5,
                                           bottom: 5,
                                           right: 5)
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    private let roomTypeCollectionView: UICollectionView = {
        
        let collection = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: layout)
        collection.tag = 0
        collection.register(RoomTypeCollectionViewCell.self,
                            forCellWithReuseIdentifier: RoomTypeCollectionViewCell.reuseId)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.clipsToBounds = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private let selectStyleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select Style"
        label.numberOfLines = 0
        label.font = UIFont(name: K.regularFontName,
                            size: 21)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private let styleCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 5,
                                               left: 5,
                                               bottom: 5,
                                               right: 5)
            layout.scrollDirection = .horizontal
            return layout
        }()
        let collection = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: layout)
        collection.tag = 1
        collection.register(StyleCollectionViewCell.self,
                            forCellWithReuseIdentifier: StyleCollectionViewCell.reuseId)
        collection.backgroundColor = .clear
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.clipsToBounds = false
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    private let spaceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let generateButton = SwipeButton()
    
    private let mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 20
        return stack
    }()
    
    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    // MARK: - Loading UI
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    
    // MARK: - Result popUp
    private let resultView = ResultView()
    
    private var resultCenterXConstraint: NSLayoutConstraint?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        generateButton.updateGradientFrame()
        promtInputView.viewDidLayoutSubviews()
    }
    
    // MARK: - Final setUp
    private func setUp() {
        // appearance
        setUpBackground()
        setUpSubviews()
        setUpSamplesStack()
        
        // logic
        setUpDelegates()
        setUpTargets()
    }
    
    
    // MARK: - Appearance
    private func setUpBackground() {
        view.backgroundColor = .black
    }
    
    private func setUpSubviews() {
        view.addSubview(topLineView)
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topLineView.topAnchor.constraint(equalTo: view.topAnchor,
                                                                      constant: 66),
                                     topLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                          constant: 15),
                                     topLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                           constant: -15),
                                     topLineView.heightAnchor.constraint(equalToConstant: 28)])
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([scrollView.topAnchor.constraint(equalTo: topLineView.bottomAnchor,
                                                                     constant: 40),
                                     scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                         constant: 15),
                                     scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                        constant: -45)])
        
        scrollView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -30)
        ])
        
        mainStack.addArrangedSubviews(samplesStack,
                                      instructionBigLabel,
                                      instructionSmallLabel,
                                      promtInputView,
                                      selectRoomLabel,
                                      roomTypeCollectionView,
                                      selectStyleLabel,
                                      styleCollectionView,
                                      spaceView)
        
        mainStack.subviews.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalTo: mainStack.widthAnchor).isActive = true
        }
        
        samplesStack.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        promtInputView.heightAnchor.constraint(lessThanOrEqualToConstant: 190).isActive = true
        promtInputView.heightAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        roomTypeCollectionView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        styleCollectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        spaceView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        view.addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([generateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                             constant: 15),
                                     generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                              constant: -15),
                                     generateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                           constant: -40),
                                     generateButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setUpSamplesStack() {
        for i in K.samplesImageNames {
            let sampleView = UIImageView()
            sampleView.contentMode = .scaleAspectFill
            sampleView.layer.cornerRadius = 12
            sampleView.clipsToBounds = true
            sampleView.image = UIImage(named: i)
            samplesStack.addArrangedSubview(sampleView)
        }
    }
    
    // MARK: - Delegates
    
    private func setUpDelegates() {
        styleCollectionView.delegate = self
        styleCollectionView.reloadData()
        
        roomTypeCollectionView.delegate = self
        roomTypeCollectionView.reloadData()
        
        resultView.delegate = self
    }
    
    // MARK: - Actions
    private func setUpTargets() {
        generateButton.addTarget(self,
                                 action: #selector(generatePressed),
                                 for: .primaryActionTriggered)
    }
    
    @objc func generatePressed() {
        presenter?.generationPressed()
    }
}

// вынести по файлам

extension GenerationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            presenter?.selectedRoom(roomId: indexPath.row)
        case 1:
            presenter?.selectedStyle(styleId: indexPath.row)
        default:
            return
        }
    }
}

extension GenerationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return (presenter?.collectionView!(collectionView, layout: collectionViewLayout, sizeForItemAt: indexPath))!
    }
}

extension GenerationViewController: GenerationViewInputProtocol {
    func showEndOfImageProcessing(withImage image: UIImage) {
        promtInputView.imageSetted(image: image)
    }
    
    func showResult(image: UIImage) {
        DispatchQueue.main.async {
            self.view.addBlur()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2)  {
            self.loadingIndicator.removeFromSuperview()
            [self.styleCollectionView,
             self.roomTypeCollectionView,
             self.generateButton].forEach { view in
                view.isUserInteractionEnabled = true
            }
            
            self.view.addSubview(self.resultView)
            self.resultCenterXConstraint?.isActive = false
            self.resultView.translatesAutoresizingMaskIntoConstraints = false
            self.resultCenterXConstraint = self.resultView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor,
                                                                                    constant: -(UIScreen.main.bounds.width / 2) - 150)
            self.resultCenterXConstraint?.isActive = true
            
            NSLayoutConstraint.activate([self.resultView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                                         self.resultView.heightAnchor.constraint(equalToConstant: 250),
                                         self.resultView.widthAnchor.constraint(equalToConstant: 300)])
            self.view.layoutIfNeeded()
            self.resultView.setImage(image: image)
            UIView.animate(withDuration: 0.6) {
                self.resultCenterXConstraint?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func showImageProcessing() {
        promtInputView.showProcessingActivity()
    }
    
    func showLoading() {
        [styleCollectionView,
         roomTypeCollectionView,
         generateButton].forEach { view in
            view.isUserInteractionEnabled = false
        }
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func showImageSelector() {
        presenter?.tappedImageSelection()
    }
    
    func updateImageSelection(withImage image: UIImage) {
        presenter?.selectedImage(image: image)
    }
    
    func updateMode(mode: InputMode) {
        /// ?????
    }
    
    func updateChoice() {
        roomTypeCollectionView.reloadData()
        styleCollectionView.reloadData()
    }
}

extension GenerationViewController: PromtInputViewDelegate {
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        let alert = UIAlertController(title: "Select Photo",
                                      message: "Choose a photo source",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera",
                                      style: .default,
                                      handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            } else {
                let alert = UIAlertController(title: "Camera Not Available",
                                              message: "Camera is not available on this device",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default))
                self.present(alert, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "Photo Library",
                                      style: .default,
                                      handler: { _ in
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker,
                         animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel))
        
        present(alert, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, 
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let editedImage = info[.editedImage] as? UIImage {
            presenter?.selectedImage(image: editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            presenter?.selectedImage(image: originalImage)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func selectMode(mode: InputMode) {
        presenter?.selectedMode(mode: mode)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.text = "Describe the interior (e.g., a modern living room with large windows and soft furniture)..." // заменить на К
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        if text == "\n" { // Check if the return key is pressed
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension GenerationViewController: ResultViewDelegate {
    func closeTapped() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.view.removeBlur()
        }
        UIView.animate(withDuration: 0.6) {
            self.resultCenterXConstraint?.constant = -(UIScreen.main.bounds.width / 2) - 150
            self.view.layoutIfNeeded()
        }
    }
    func saveImage(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }) { success, error in
                    if success {
                        self.resultView.imageSaved()
                    } else if let error = error {
                        print("Error saving image: \(error.localizedDescription)")
                    } else {
                        print("Unknown error occurred")
                    }
                }
                // потом сделать алерт с предложением пойти в настройки
            case .denied, .restricted:
                print("Access to photo library is denied or restricted")
            case .notDetermined:
                print("Access to photo library is not determined")
            case .limited:
                print("Access to photo library is limited")
            @unknown default:
                print("Unknown authorization status")
            }
        }
    }
}
