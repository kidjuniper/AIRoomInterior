//
//  CollectionViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 22.07.2024.
//

import UIKit

class StyleCollectionViewCell: UICollectionViewCell {
    
    let styleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let styleNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.regularFontName,
                            size: 15)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    static let reuseId = "StyleCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        styleImage.layer.cornerRadius = 10
        styleImage.clipsToBounds = true
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        addSubview(styleImage)
        styleImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            styleImage.topAnchor.constraint(equalTo: topAnchor),
            styleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            styleImage.heightAnchor.constraint(equalToConstant: 90),
            styleImage.widthAnchor.constraint(equalToConstant: 120),
        ])
        
        addSubview(styleNameLabel)
        styleNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            styleNameLabel.topAnchor.constraint(equalTo: styleImage.bottomAnchor,
                                               constant: 5),
            styleNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    func configurate(cellData data: RoomStyleCellData) {
        styleImage.image = UIImage(named: data.styleImageName)
        styleNameLabel.text = data.styleName
        if data.isSelected {
            styleImage.layer.opacity = 1
        }
        else {
            styleImage.layer.opacity = 0.5
        }
        layer.cornerRadius = 15
        clipsToBounds = true
    }
}
