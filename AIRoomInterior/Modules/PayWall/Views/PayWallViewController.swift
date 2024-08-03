//
//  PayWallViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 31.07.2024.
//

import UIKit

class PayWallViewController: UIViewController {
    var presenter: PayWallOutputProtocol?
    
    // MARK: - UI elements
    private lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Archie"
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName,
                            size: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var payWallCell: UIView = {
        let view = PayWallView()
        let model = OnboardingViewModel(type: .PayWall,
                                        mainImage: UIImage(named: "emptyRoom")!,
                                        secondaryImages: RoomStyle.allCases.map({ style in
                UIImage(named: style.rawValue)!
            }),
                                        subTitles: RoomStyle.allCases.map({ style in
                style.rawValue
            }),
                                        title: """
    Unlock Full Access
    to all the features
    """,
                                        text: """
    Start to continue App
    just for $6.99 per week
    """)
        view.configure(model: model)
        view.appearing()
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue",
                        for: .normal)
        button.layer.cornerRadius = 15
        button.tintColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"),
                            for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private lazy var inAppButtonsView = NeccessaryInAppButtonsView()
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        confirmButton.applyGradient()
    }
    
    // MARK: - Final SetUp
    private func setUp() {
        setUpLayout()
        setUpDelegates()
        setUpTargets()
        view.backgroundColor = UIColor(named: "Black") // занести в K
    }
    
    // MARK: - Appearance
    private func setUpLayout() {
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                                   constant: UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? 66 : 30),
                                     topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([backButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
                                     backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                        constant: -20),
                                     backButton.widthAnchor.constraint(equalToConstant: 30),
                                     backButton.heightAnchor.constraint(equalToConstant: 30)])
        
        view.addSubview(payWallCell)
        payWallCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([payWallCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     payWallCell.topAnchor.constraint(equalTo: topLabel.bottomAnchor),
                                     payWallCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     payWallCell.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                         constant: -90)
        ])
        
        view.addSubview(confirmButton)
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([confirmButton.topAnchor.constraint(equalTo: payWallCell.bottomAnchor,
                                                                       constant: 10),
                                     confirmButton.heightAnchor.constraint(equalToConstant: 50),
                                     confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                            constant: 12),
                                     confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                            constant: -12)
        ])
        
        view.addSubview(inAppButtonsView)
        inAppButtonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([inAppButtonsView.topAnchor.constraint(equalTo: confirmButton.bottomAnchor),
                                     inAppButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     inAppButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     inAppButtonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
    
    // MARK: - Actions
    private func setUpTargets() {
        backButton.addTarget(self,
                             action: #selector(backButtonPressed),
                             for: .touchUpInside)
        confirmButton.addTarget(self,
                                action: #selector(confirmPurchasePressed),
                                for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        presenter?.backPressed()
    }
    
    @objc func confirmPurchasePressed() {
        presenter?.confirmPurchasePressed()
    }
    
    // MARK: - Delegates
    private func setUpDelegates() {
        inAppButtonsView.delegate = self
    }
}

extension PayWallViewController: NeccessaryInAppButtonsViewDelegate {
    func privacyPolicyTapped() {
        presenter?.privacyPolicyTapped()
    }
    
    func restorePurchaseTapped() {
        presenter?.restorePurchaseTapped()
    }
    
    func termsOfUseTapped() {
        presenter?.termsOfUseTapped()
    }
}

extension PayWallViewController: PayWallInputProtocol {
    func goBack() {
        self.dismiss(animated: true)
    }
}
