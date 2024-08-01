//
//  SettingsTableViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    static let cellId = "SettingsTableViewCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: K.boldFontName, size: 15)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: 3),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                 constant: -3),
            
            iconImage.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                               constant: 10),
            iconImage.heightAnchor.constraint(equalToConstant: 24),
            iconImage.widthAnchor.constraint(equalToConstant: 24)
        ])
        
        containerView.addSubview(titleLable)
        titleLable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: iconImage.trailingAnchor,
                                               constant: 10)
        ])
    }
    
    // MARK: - Configuration
    func configure(withData data: SettingsTableCellData) {
        titleLable.text = data.title
        iconImage.image = UIImage(systemName: data.imageName)
    }
}

extension SettingsTableViewCell: AnimatableSettingsTableViewCell {
    func animatePressing() {
        UIView.animate(withDuration: 0.02) {
            self.contentView.alpha = 0.5
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.contentView.alpha = 1
            }
        }

    }
}
