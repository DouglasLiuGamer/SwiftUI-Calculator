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
                AnsView(
                    ans: processor.prevAns,
                    precision: processor.precision
                )

                Spacer()

                Button(action: {
                    self.processor.precision += 1
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                }
            }

            Divider()
                .padding(.vertical, 10)

            HStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: true) {
                    EquationView(tokens: processor.tokens)

                    ResultView(
                        result: processor.ans,
                        precision: processor.precision
                    )
                }

                if !processor.tokens.isEmpty {
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
