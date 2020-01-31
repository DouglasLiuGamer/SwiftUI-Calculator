//
//  ButtonView.swift
//  Calculator
//
//  Created by Douglas Liu on 1/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct TextButton: View {
    var symbol: String
    var disabled: Bool

    var body: some View {
        Button(action: {
            if (!self.disabled) {
                if self.processor.allowVibration {
                    Vibration.impactOccured()
                }
                self.processor.receive(symbol: self.symbol)
            }
        }) {
            Text(self.symbol)
                .font(.system(
                    size: 22,
                    weight: .semibold,
                    design: .monospaced))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    @EnvironmentObject private var processor: Processor
}

#if DEBUG
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(symbol: "+", disabled: false).environmentObject(Processor())
    }
}
#endif
