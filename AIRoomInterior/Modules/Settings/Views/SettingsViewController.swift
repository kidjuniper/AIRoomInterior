//
//  SettingsViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    var presenter: SettingsPresenter? {
        didSet {
            tableView.delegate = self
            tableView.dataSource = presenter
        }
    }
    
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
        button.setImage(UIImage(named: "arrow"),
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
        stack.spacing = 5
        return stack
    }()
    
    private lazy var topUnlockPremiumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 23)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Unlock Premium"
        return label
    }()
    
    private lazy var bottomUnlockPremiumLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName, size: 15)
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Access premium features"
        return label
    }()
    
    private lazy var unlockPremiumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get",
                       for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SettingsTableViewCell.self,
                           forCellReuseIdentifier: SettingsTableViewCell.cellId)
        tableView.isScrollEnabled = false 
        return tableView
    }()
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Final SetUp
    private func setUp() {
        setUpStack()
        setUpLayout()
        setUpTargets()
    }
    
    // MARK: - Appearance
    private func setUpLayout() {
        view.addSubview(settingsLabel)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([settingsLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                                        constant: 66),
                                     settingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                        constant: 12),
                                     backButton.centerYAnchor.constraint(equalTo: settingsLabel.centerYAnchor),
                                     backButton.widthAnchor.constraint(equalToConstant: 24),
                                     backButton.heightAnchor.constraint(equalToConstant: 24),
        ])
        
        view.addSubview(premiumOfferBackgroundImageView)
        premiumOfferBackgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([premiumOfferBackgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                        constant: 12),
                                     premiumOfferBackgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                                              constant: -12),
                                     premiumOfferBackgroundImageView.heightAnchor.constraint(equalToConstant: 130),
                                     premiumOfferBackgroundImageView.topAnchor.constraint(equalTo: settingsLabel.bottomAnchor,
                                                                                          constant: 20)
        ])
        
        premiumOfferBackgroundImageView.addSubview(unlockPremiumLabelsStack)
        unlockPremiumLabelsStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([unlockPremiumLabelsStack.bottomAnchor.constraint(equalTo: premiumOfferBackgroundImageView.bottomAnchor,
                                                                                      constant: -15),
                                     unlockPremiumLabelsStack.leadingAnchor.constraint(equalTo: premiumOfferBackgroundImageView.leadingAnchor,
                                                                                      constant: 10)
        ])
        
        view.addSubview(unlockPremiumButton)
        unlockPremiumButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([unlockPremiumButton.bottomAnchor.constraint(equalTo: premiumOfferBackgroundImageView.bottomAnchor,
                                                                                 constant: -15),
                                     unlockPremiumButton.trailingAnchor.constraint(equalTo: premiumOfferBackgroundImageView.trailingAnchor,
                                                                                      constant: -10),
                                     unlockPremiumButton.leadingAnchor.constraint(equalTo: unlockPremiumLabelsStack.trailingAnchor,
                                                                                       constant: 40),
                                     unlockPremiumButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                      constant: -10),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                                      constant: 12),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                       constant: -12),
                                     tableView.topAnchor.constraint(equalTo: premiumOfferBackgroundImageView.bottomAnchor,
                                                                    constant: 20)
        ])
    }
    
    private func setUpStack() {
        unlockPremiumLabelsStack.addArrangedSubviews(topUnlockPremiumLabel,
                                  bottomUnlockPremiumLabel)
    }
    
    // MARK: - Actions
    private func setUpTargets() {
        backButton.addTarget(self,
                             action: #selector(backButtonPressed),
                             for: .touchUpInside)
        unlockPremiumButton.addTarget(self,
                                      action: #selector(premiumButtonPressed),
                                      for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        presenter?.backButtonPressed()
    }
    
    @objc func premiumButtonPressed() {
        presenter?.premiumTapped()
    }
}

extension SettingsViewController: SettingsViewInputProtocol {
    func goBack() {
        self.dismiss(animated: true)
    }
    
    func showRatingRequest() {
        RatingManager().requestRating()
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, 
                   viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = UIFont(name: K.regularFontName,
                            size: 17)
        label.textColor = .white
        
        headerView.addSubview(label)
        switch section {
        case 0:
            label.text = "Share"
        default:
            label.text = "Terms & Privacy"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cellPresed(indexPath: indexPath)
        if let animatableCell = tableView.cellForRow(at: indexPath) as? AnimatableSettingsTableViewCell {
            animatableCell.animatePressing()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        59
    }
}
