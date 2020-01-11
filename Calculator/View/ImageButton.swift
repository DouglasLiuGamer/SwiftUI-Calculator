//
//  ImageButton.swift
//  Calculator
//
//  Created by Douglas Liu on 1/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct ImageButton: View {
    @EnvironmentObject var processor: Processor

    var symbol: String
    var imageName: String
    var disabled: Bool

    var body: some View {
        Button(action: {
            if (!self.disabled) {
                self.processor.receive(symbol: self.symbol)
            }
        }) {
            Image(systemName: imageName)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#if DEBUG
struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(symbol: "/", imageName: "divide", disabled: false)
            .environmentObject(Processor())
    }
}
#endif
