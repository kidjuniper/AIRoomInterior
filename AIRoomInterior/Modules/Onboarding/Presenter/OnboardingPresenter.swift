//
//  OnboardingPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import UIKit
import StoreKit

class OnboardingPresenter: NSObject {
    weak var viewController: OnboardingViewInputProtocol?
    let store = PurchaseManager()
    
    // MARK: - Private Properties
    private let sceneBuildManager: Buildable
    private var onboardingData: [OnboardingViewModelProtocol] = [OnboardingViewModel]()
//    private let defaultsManager: DefaultsManagerable
    
    // MARK: - Initializer
    init(viewController: OnboardingViewInputProtocol,
         onboardingData: [OnboardingViewModelProtocol],
         sceneBuildManager: Buildable) {
        self.viewController = viewController
        self.onboardingData = onboardingData
        self.sceneBuildManager = sceneBuildManager
    }
}

extension OnboardingPresenter: OnboardingPresenterProtocol {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return onboardingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: OnboardingSlideProtocol?
       
        let model = onboardingData[indexPath.row]
        switch model.type {
        case .Triptych:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingTriptychCollectionViewCell.cellId,
                                                                for: indexPath) as? OnboardingTriptychCollectionViewCell
            cell?.configure(model: model)
            return cell!
        case .Cross:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCrossCollectionViewCell.cellId,
                                                                for: indexPath) as? OnboardingCrossCollectionViewCell
            cell?.configure(model: model)
            return cell!
        case .Lines:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingLinesCollectionViewCell.cellId,
                                                                for: indexPath) as? OnboardingLinesCollectionViewCell
            cell?.configure(model: model)
            return cell!
        case .PayWall:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PayWallCollectionViewCell.cellId,
                                                                for: indexPath) as? PayWallCollectionViewCell
            cell?.configure(model: model)
            return cell!
        }
    }
    
    func viewDidLoad() {
        viewController?.dataSetted(withPageNumber: onboardingData.count)
    }
    
    func nextScreenButtonTapped(currentPage: Int) {
        if currentPage == 3 {
            viewController?.showInAppAttributes()
        }
        if currentPage == 4 {
            subscribe()
            return
        }
        let indexPath = IndexPath(row: currentPage,
                                  section: 0)
        viewController?.scrollToNextScreen(indexPath: indexPath)
    }
    
    func privacyPolicyTapped() {
        if let url = URL(string: "https://telegra.ph/Archie---AI-Home-Design-07-31") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func restorePurchaseTapped() {
        Task {
            do {
                try await AppStore.sync()
            } catch {
                print(error)
            }
        }
    }
    
    func termsOfUseTapped() {
        if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    func subscribe() {
        Task {
            for value in store.subscriptions {
                await buy(product: value)
            }
        }
    }
    
    func buy(product: Product) async {
        do {
            if try await store.purchase(product) != nil {
                getNextVC()
            }
        } catch {
            print("purchase failed")
        }
    }
    
    func getNextVC() {
        DispatchQueue.main.async {
            let mainViewController = self.sceneBuildManager.buildGenerateScreen()
            let rootViewController = UINavigationController(rootViewController: mainViewController)
            let allScenes = UIApplication.shared.connectedScenes
            let scene = allScenes.first { $0.activationState == .foregroundActive }
            if let windowScene = scene as? UIWindowScene { windowScene.keyWindow?.rootViewController = rootViewController
            }
        }
    }
}
