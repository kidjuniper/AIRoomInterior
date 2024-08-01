//
//  GeneratorPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 22.07.2024.
//

import Foundation
import UIKit

final class GeneratorPresenter: NSObject,
                                GeneratorPresenterProtocol {
    weak var view: GenerationViewInputProtocol?
    var sceneBuildManager: Buildable?
    
    // вынести в константы
    private var promtDescription: String = ""
    
    private let roomTypesArray: [String] = RoomType.allCases.map { roomType in
        roomType.rawValue
    }
    
    private let stylesImageArray: [String] = K.styleImages
    
    private let stylesNamesArray: [String] = RoomStyle.allCases.map { style in
        style.rawValue
    }
    
    // -----
    
    private var selectedRoomId: Int = 0 {
        didSet {
            view?.updateChoice()
        }
    }
    private var selectedStyleId: Int = 0 {
        didSet {
            view?.updateChoice()
        }
    }
    
    private var mode: InputMode = .text
}

extension GeneratorPresenter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            roomTypesArray.count
        case 1:
            stylesImageArray.count
        default:
            0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RoomTypeCollectionViewCell.reuseId,
                                                          for: indexPath) as! RoomTypeCollectionViewCell
            let cellData = RoomTypeCellData(roomName: roomTypesArray[indexPath.row],
                                            isSelected: indexPath.row == selectedRoomId)
            cell.configurate(cellData: cellData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCollectionViewCell.reuseId,
                                                          for: indexPath) as! StyleCollectionViewCell
            let cellData = RoomStyleCellData(styleImageName: stylesImageArray[indexPath.row],
                                             styleName: stylesNamesArray[indexPath.row],
                                             isSelected: indexPath.row == selectedStyleId)
            cell.configurate(cellData: cellData)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension GeneratorPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 0:
            return CGSize(width: roomTypesArray[indexPath.row].generateWidth(),
                          height: 34)
        case 1:
            return CGSize(width: 120,
                          height: 120)
        default:
            return CGSize.zero
        }
    }
}

extension GeneratorPresenter: GenerationViewOutputProtocol {
    func tappedPro() {
        let newViewController = sceneBuildManager!.buildPayWallScreen()
        newViewController.modalTransitionStyle = .coverVertical
        newViewController.modalPresentationStyle = .pageSheet
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        if let windowScene = scene as? UIWindowScene { windowScene.keyWindow?.rootViewController?.present(newViewController,
                                                                                      animated: true)
        }
    }
    
    func tappedSetttings() {
        let newViewController = sceneBuildManager!.buildSettingsScreen()
        newViewController.modalTransitionStyle = .flipHorizontal
        newViewController.modalPresentationStyle = .fullScreen
        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }
        if let windowScene = scene as? UIWindowScene { windowScene.keyWindow?.rootViewController?.present(newViewController,
                                                                                      animated: true)
        }
    }
    
    func tappedImageSelection() {
        view?.showImageSelector()
    }
    
    func returnDescr() -> String {
        promtDescription += "The room MUST be a" + roomTypesArray[selectedRoomId] + " It's the most important!"
        promtDescription += "The room design MUST be in the \(stylesImageArray[selectedStyleId]) style"
        return promtDescription
    }
    
    func selectedImage(image: UIImage) {
        view?.showImageProcessing()
        ImageAnalysisManager.shared.detectObjects(in: image) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let description):
                    // temprorary check
                    var aditionalDescription = "ALL these objects MUST be in the picture as INTERIOR DETAILS: "
                    for i in description.amazon!.items! {
                        if i.confidence ?? 0.0 >= 0.7 {
                            aditionalDescription += " \(String(describing: i.label!)),"
                        }
                    }
                    self.promtDescription = "Make me a design of the room." + aditionalDescription
                    self.view?.showEndOfImageProcessing(withImage: image)
                    
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func settedDescription(text: String) {
        promtDescription = text
    }
    
    func selectedMode(mode: InputMode) {
    }
    
    // здесь на кложуре сделать (опционально)
    func generationPressed()  {
        view?.showLoading()
        KandinskyAPIManager.shared.authenticate { result in
            switch result {
            case .success(let modelId):
                KandinskyAPIManager.shared.generateImage(prompt: self.returnDescr()) { result in
                    switch result {
                    case .success(let uuid):
                        print("Image generation started with UUID: \(uuid)")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                                self.checkImageGenerationState(withId: uuid)
                        }
                    case .failure(let error):
                        print("Error generating image: \(error.localizedDescription)")
                    }
                }
            case .failure(let error):
                print("Authentication failed: \(error.localizedDescription)")
            }
        }
    }
    
    func checkImageGenerationState(withId uuid: String) {
        KandinskyAPIManager.shared.checkGenerationStatus(uuid: uuid) { result in
            switch result {
            // здесь делаем круг для чека: пока не сделает картинку не перестанет. ДОБАВИТЬ ЛИМИТ
            case .success(let images):
                self.view?.showResult(image: self.image(from: images.first!) ?? UIImage())
            case .failure(let error):
                KandinskyAPIManager.shared.checkGenerationStatus(uuid: uuid) { result in
                    switch result {
                    case .success(let images):
                        self.view?.showResult(image: self.image(from: images.first!) ?? UIImage())
                    case .failure(let error):
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                self.checkImageGenerationState(withId: uuid)
                        }
                    }
                }
            }
        }
    }
    
    func selectedStyle(styleId id: Int) {
        selectedStyleId = id
    }
    
    func selectedRoom(roomId id: Int) {
        selectedRoomId = id
    }
}

protocol GeneratorPresenterProtocol: UICollectionViewDataSource,
                                     UICollectionViewDelegateFlowLayout,
                                     GenerationViewOutputProtocol {
    
}

extension NSObject {
    func image(from base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            print("Error decoding Base64 string")
            return nil
        }
        return UIImage(data: imageData)
    }
}
