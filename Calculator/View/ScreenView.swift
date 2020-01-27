//
//  EquationView.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

struct ScreenView: View {
    @EnvironmentObject var processor: Processor

    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                Text(processor.prevAns.isEmpty ? "" : "ANS=\(processor.prevAns)")
                    .font(.system(size: 22, weight: .regular, design: .monospaced))
                    .lineLimit(1)

                Spacer()

                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
            }

            Divider()
                .padding(.vertical, 10)

            HStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: true) {
                    EquationView(tokens: processor.tokens)

                    Text(processor.ans)
                        .font(.system(size: 35, weight: .bold, design: .monospaced))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(nil)
                }

                if !processor.equation.isEmpty {
                    Button(action: {
                        self.processor.resetEquation()
                    }) {
                        Image(systemName: "trash.fill")
                            .imageScale(.large)
                            .padding(.vertical)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
            .environmentObject(Processor())
            .padding()
    }
}
#endif
