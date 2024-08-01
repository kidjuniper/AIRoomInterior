//
//  PayWallViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 31.07.2024.
//

import UIKit

class PayWallViewController: UIViewController {
    
    // MARK: - UI elements
    private lazy var payWallCell: UIView = {
        let view = PayWallView()
        let model = OnboardingViewModel(type: .PayWall,
                                        mainImage: UIImage(named: "emptyRoom")!,
                                        secondaryImages: RoomStyle.allCases.map({ style in
                UIImage(named: style.rawValue)!
            }) + [UIImage(named: RoomStyle.modern.rawValue)!],
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
    
    // MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - Final SetUp
    private func setUp() {
        setUpLayout()
    }
    
    // MARK: - Appearance
    private func setUpLayout() {
        view.addSubview(payWallCell)
        payWallCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([payWallCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     payWallCell.topAnchor.constraint(equalTo: view.topAnchor),
                                     payWallCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     payWallCell.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
