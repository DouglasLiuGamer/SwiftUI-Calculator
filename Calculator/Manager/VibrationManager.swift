//
//  VibrationManager.swift
//  Calculator
//
//  Created by Douglas Liu on 30/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import UIKit

class VibrationManager {
    static func onImpactOccured() {
        impactGenerator.impactOccurred()
    }

    static private let impactGenerator = UIImpactFeedbackGenerator(style: .light)
}
