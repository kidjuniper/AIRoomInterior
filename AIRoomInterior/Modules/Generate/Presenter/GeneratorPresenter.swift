//
//  GeneratorPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 22.07.2024.
//

import Foundation
import UIKit

final class GeneratorPresenter: NSObject, GeneratorPresenterProtocol {
    weak var view: GenerationViewInputProtocol?
    
    private let roomTypesArray: [String] = RoomType.allCases.map { roomType in
        roomType.rawValue
    }
    private let stylesImageArray: [String] = K.styleImages
    
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
                                            isSelected: false)
            cell.configurate(cellData: cellData)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StyleCollectionViewCell.reuseId,
                                                          for: indexPath) as! StyleCollectionViewCell
            cell.configurate(imageName: stylesImageArray[indexPath.row])
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
            return CGSize(width: 100,
                          height: 100)
        default:
            return CGSize.zero
        }
    }
}

extension GeneratorPresenter: GenerationViewOutputProtocol {
    func selectStyle(styleId id: Int) {
        selectedStyleId = id
    }
    
    func selectRoom(roomId id: Int) {
        selectedRoomId = id
    }
}

protocol GeneratorPresenterProtocol: UICollectionViewDataSource,
                                     UICollectionViewDelegateFlowLayout,
                                     GenerationViewOutputProtocol {
    
}
