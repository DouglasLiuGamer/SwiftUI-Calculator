//
//  EquationView.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

struct ScreenView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack() {
                AnsView(
                    ans: processor.prevAns,
                    precision: processor.precision,
                    dimmed: processor.ans != nil
                )

                Spacer()

                Button(action: {
                    self.showSettings = true
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                }
                .sheet(isPresented: $showSettings) {
                    SettingView()
                        .environmentObject(self.processor)
                }
            }

            Divider()
                .padding(.vertical, 10)

            HStack(alignment: .bottom) {
                ScrollView(.vertical, showsIndicators: true) {
                    EquationView(
                        tokens: processor.tokens,
                        dimmed: processor.ans != nil
                    )

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

    @State private var showSettings = false
    @EnvironmentObject private var processor: Processor
}

#if DEBUG
struct ScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenView()
            .environmentObject(Processor())
            .padding()
            .accentColor(Color("Accent"))
    }
}
#endif
