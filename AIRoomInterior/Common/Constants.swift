//
//  Constants.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 21.07.2024.
//

import Foundation
import UIKit

struct K {
    static let boldFontName = "Inter Bold"
    static let regularFontName = "Inter"
    
    static let profileImageName = "profileImage"
    static let premiumBackgroundImageName = "backgroundImage"

    static let styleImages: [String] = RoomStyle.allCases.map { style in
        style.rawValue
    }
    
    static let samplesImageNames = ["sample1", "sample2", "sample3", "sample4"]
}
