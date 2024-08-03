//
//  OnboardingViewController.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - UI components
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Archie"
        label.numberOfLines = 0
        label.font = UIFont(name: K.boldFontName,
                            size: 23)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = .init(width: UIScreen.main.bounds.width,
                                          height: UIScreen.main.bounds.height * 0.92)
        collectionLayout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionLayout)
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        
        collection.contentInsetAdjustmentBehavior = .never
        collection.bounces = false
        collection.isUserInteractionEnabled = false
        
        collection.register(OnboardingTriptychCollectionViewCell.self,
                            forCellWithReuseIdentifier: OnboardingTriptychCollectionViewCell.cellId)
        collection.register(OnboardingCrossCollectionViewCell.self,
                            forCellWithReuseIdentifier: OnboardingCrossCollectionViewCell.cellId)
        collection.register(OnboardingLinesCollectionViewCell.self,
                            forCellWithReuseIdentifier: OnboardingLinesCollectionViewCell.cellId)
        collection.register(PayWallCollectionViewCell.self,
                            forCellWithReuseIdentifier: PayWallCollectionViewCell.cellId)
        return collection
    }()
    
    private let pageControl = CustomPageControl()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue",
                        for: .normal)
        button.layer.cornerRadius = 15
        button.tintColor = .white
        button.clipsToBounds = true
        button.addTarget(self,
                         action: #selector(nextButtonAction),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var inAppButtonsView = NeccessaryInAppButtonsView()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"),
                        for: .normal)
        button.tintColor = .white
        button.addTarget(self,
                         action: #selector(skipButtonAction),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    var presenter: OnboardingPresenterProtocol? {
        didSet {
            collectionView.dataSource = presenter
            collectionView.delegate = self
            
            collectionView.reloadData()
        }
    }
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        setupUI()
        presenter?.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.applyGradient()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc private func skipButtonAction() {
        presenter?.getNextVC()
    }
    
    @objc private func nextButtonAction() {
        currentPage += 1
        presenter?.nextScreenButtonTapped(currentPage: currentPage)
    }
}

// MARK: - OnboardingViewProtocol
extension OnboardingViewController: OnboardingViewInputProtocol {
    func showInAppAttributes() {
        inAppButtonsView.delegate = self
        view.addSubview(inAppButtonsView)
        inAppButtonsView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([inAppButtonsView.topAnchor.constraint(equalTo: nextButton.bottomAnchor),
                                     inAppButtonsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     inAppButtonsView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     inAppButtonsView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        animateInAppButtonsAppearance()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showSkipButton()
        }
    }
    
    func animateInAppButtonsAppearance() {
        inAppButtonsView.layer.opacity = 0
        UIView.animate(withDuration: 1) {
            self.inAppButtonsView.layer.opacity = 1
        }
    }
    
    func dataSetted(withPageNumber number: Int) {
        collectionView.reloadData()
        pageControl.numberOfPages = number
    }
    
    func showSkipButton() {
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([skipButton.centerYAnchor.constraint(equalTo: topLabel.centerYAnchor),
                                     skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                         constant: -20),
                                     skipButton.heightAnchor.constraint(equalToConstant: 40),
                                     skipButton.widthAnchor.constraint(equalToConstant: 40)])
        skipButtonAppearance()
    }
    
    func skipButtonAppearance() {
        skipButton.layer.opacity = 0
        UIView.animate(withDuration: 1) {
            self.skipButton.layer.opacity = 1
        }
    }
    
    func scrollToNextScreen(indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionView.isPagingEnabled = false
            self.collectionView.scrollToItem(at: indexPath,
                                             at: .right,
                                             animated: true)
            self.collectionView.isPagingEnabled = true
        }
    }
}

extension OnboardingViewController: NeccessaryInAppButtonsViewDelegate {
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

// MARK: - UICollectionViewDelegate
extension OnboardingViewController: UICollectionViewDelegate,
                                    UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        guard let appearingCell = cell as? OnboardingSlideProtocol else { return }
        appearingCell.appearing()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width,
                      height: self.collectionView.frame.height)
    }
}

// MARK: - Private extension
private extension OnboardingViewController {
    func setupUI() {
        setUpStackViews()
        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor(named: "Black")
    }
    
    func setUpStackViews() {
        mainStack.addArrangedSubviews(pageControl,
                                          nextButton)
    }
    
    func setupViews() {
        view.backgroundColor = .black
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                                   constant: UIScreen.main.bounds.height / UIScreen.main.bounds.width > 2 ? 66 : 30),
                                     topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
    }
    
    func setupConstraints() {
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor,
                                                constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: mainStack.topAnchor,
                                                  constant: -10),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                      constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -30),
            mainStack.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
