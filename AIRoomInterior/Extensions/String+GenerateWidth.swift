//
//  String+GenerateWidth.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 30.07.2024.
//

import Foundation

extension String {
    func generateWidth() -> CGFloat {
        return CGFloat(max(20,
                           (self.count) * 10 + 10))
    }
}
