//
//  RoomTypeCollectionViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 23.07.2024.
//

import UIKit

class RoomTypeCollectionViewCell: UICollectionViewCell {
    
    let roomNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.regularFontName,
                            size: 15)
        label.textAlignment = .center
        return label
    }()
    
    static let reuseId = "RoomTypeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(roomNameLabel)
        roomNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            roomNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            roomNameLabel.widthAnchor.constraint(equalTo: widthAnchor),
            roomNameLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    func configurate(cellData data: RoomTypeCellData) {
        if data.isSelected {
            roomNameLabel.backgroundColor = .darkGray
            roomNameLabel.textColor = .lightGray
        }
        else {
            roomNameLabel.backgroundColor = .systemBlue
            roomNameLabel.textColor = .darkGray
        }
        roomNameLabel.text = data.roomName
        roomNameLabel.layer.cornerRadius = 15
        roomNameLabel.clipsToBounds = true
    }
}

extension RoomTypeCollectionViewCell: RoomTypeCollectionViewCellProtocol {
    func set(object: RoomTypeCellData) {
        configurate(cellData: object)
    }
}

struct RoomTypeCellData {
    var roomName: String
    var isSelected: Bool
}

protocol RoomTypeCollectionViewCellProtocol {
    func set(object: RoomTypeCellData)
}

extension String {
    func generateWidth() -> CGFloat {
        return CGFloat(max(20,
                           (self.count) * 10 + 10))
    }
}
