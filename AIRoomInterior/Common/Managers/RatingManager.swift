//
//  RatingManager.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 31.07.2024.
//

import Foundation
import UIKit
import StoreKit

class RatingManager {
    func requestRating() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }
}
