//
//  OnboardingSlide.swift
//  AIRoomInterior
//
//  Created by Nikita Stepanov on 29.07.2024.
//

import Foundation
import UIKit

struct OnboardingSlide {
    let title: String
    let description: String
    let imageName: String
}

protocol OnboardingViewModelProtocol {
    var type: OnboardingSlideType { get }
    var mainImage: UIImage { get }
    var secondaryImages: [UIImage] { get }
    var title: String { get }
    var text: String { get }
}

struct OnboardingViewModel: OnboardingViewModelProtocol {
    
    var type: OnboardingSlideType
    var mainImage: UIImage
    var secondaryImages: [UIImage]
    let title: String
    let text: String
    
    static var makeModel: [OnboardingViewModel] {
        return [OnboardingViewModel(type: .Triptych,
                                    mainImage: UIImage(named: "center")!,
                                    secondaryImages: [UIImage(named: "left")!,
                                                      UIImage(named: "right")!],
                                    title: """
Welcome to
Al Interior Design
""",
                                    text: """
Instantly redesign
your home with Al
"""),
                OnboardingViewModel(type: .Cross,
                                    mainImage: UIImage(named: "iphoneOnboarding")!,
                                    secondaryImages: [UIImage(named: "samplesLine")!],
                                    title: """
Take a photo
of your room
""",
                                    text: """
Choose a style
to design your room
"""),
                OnboardingViewModel(type: .Lines,
                                    mainImage: UIImage(named: "center")!,
                                    secondaryImages: RoomStyle.allCases.map({ style in
            UIImage(named: style.rawValue)!
        }) + [UIImage(named: RoomStyle.modern.rawValue)!],
                                    title: """
One tap,
infinite designs
""",
                                    text: """
Get instant, detailed, and accurate interior
design options
"""),
                OnboardingViewModel(type: .PayWall,
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
        ]
    }
}

enum OnboardingSlideType {
    case Triptych
    case Cross
    case Lines
    case PayWall
}
