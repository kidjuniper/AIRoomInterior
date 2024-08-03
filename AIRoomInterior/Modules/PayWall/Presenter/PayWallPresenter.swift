//
//  PayWallPresenter.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 02.08.2024.
//

import Foundation
import StoreKit

final class PayWallPresenter: NSObject {
    weak var viewController: PayWallInputProtocol?
    let store = PurchaseManager()
}

extension PayWallPresenter: PayWallOutputProtocol {
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
    
    func backPressed() {
        viewController?.goBack()
    }
    
    func confirmPurchasePressed() {
        Task {
            for value in store.subscriptions {
                await buy(product: value)
            }
        }
    }
    
    func buy(product: Product) async {
        do {
            if try await store.purchase(product) != nil {
//                getNextVC()
            }
        } catch {
            print("purchase failed")
        }
    }
}
