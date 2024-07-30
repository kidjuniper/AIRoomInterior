//
//  SettingsTableViewCell.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellId = "SettingsTableViewCell"
    
    // MARK: - UI Components
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton(type: .system)
        let shareImage = UIImage(systemName: "square.and.arrow.up")
        button.setImage(shareImage, for: .normal)
        button.setTitle(" Share this App", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        contentView.addSubview(containerView)
        containerView.addSubview(shareButton)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            shareButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            shareButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16)
        ])
    }
    
    // MARK: - Configuration
    func configure() {
        // Здесь вы можете добавить любую логику конфигурации, если это необходимо.
    }
}

