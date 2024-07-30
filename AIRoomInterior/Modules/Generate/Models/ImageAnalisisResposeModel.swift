//
//  ImageAnalisisResposeModel.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 24.07.2024.
//

import Foundation

// MARK: - ImageAnalisisResposeModel
struct ImageAnalisisResposeModel: Codable {
    let amazon, google, edenAI: Amazon?

    enum CodingKeys: String, CodingKey {
        case amazon, google
        case edenAI = "eden-ai"
    }
}

// MARK: - Amazon
struct Amazon: Codable {
    let items: [Item]?
    let status: String?
    let cost: Double?
}

// MARK: - Item
struct Item: Codable {
    let label: String?
    let confidence: Double?
    let xMin, xMax, yMin, yMax: Double?

    enum CodingKeys: String, CodingKey {
        case label, confidence
        case xMin = "x_min"
        case xMax = "x_max"
        case yMin = "y_min"
        case yMax = "y_max"
    }
}
