//
//  SettingsViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - UI elements
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName,
                            size: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "threeLines"),
                            for: .normal)
        return button
    }()
    
    private lazy var premiumOfferBackgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: K.premiumBackgroundImageName))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12 // возможно поменять на константу везде
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var unlockPremiumLabelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 15
        return stack
    }()
    
    private lazy var topUnlockPremiumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 23)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var bottomUnlockPremiumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 15)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Lyfe Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Appearance
    
    private func setUpLayout() {
        view.addSubview(settingsLabel)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([settingsLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                                        constant: 66)])
    }
}


extension SettingsViewController: SettingsViewInputProtocol {
    
}
