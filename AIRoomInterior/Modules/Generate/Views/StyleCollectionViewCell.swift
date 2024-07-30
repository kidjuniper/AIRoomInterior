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
            styleImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            styleImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            styleImage.heightAnchor.constraint(equalToConstant: 90),
            styleImage.widthAnchor.constraint(equalToConstant: 90),
        ])
    }
    
    func configurate(imageName: String) {
        styleImage.image = UIImage(named: imageName)
    }
}
