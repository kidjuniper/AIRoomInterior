//
//  AccessManager.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 01.08.2024.
//

import Foundation

final class AccessManager {
    static let store = PurchaseManager()
    static let shared = AccessManager()
    
    func checkAccess() -> Bool {
        if !AccessManager.store.subscriptions.isEmpty {
            return true
        }
        return false
    }
}
