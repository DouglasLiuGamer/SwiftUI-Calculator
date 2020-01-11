//
//  EquationView.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

struct EquationView: View {
    @EnvironmentObject var processor: Processor

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            if !processor.prevAns.isEmpty {
                HStack {
                    Text("ANS=\(processor.prevAns)")
                        .font(.system(.body, design: .monospaced))
                    Spacer()
                }
                Divider()
            }

            HStack {
                Text(processor.equation)
                    .font(.system(.body, design: .monospaced))
                Spacer()
            }

            if !processor.ans.isEmpty {
                HStack {
                    Text(processor.ans)
                        .font(.system(.largeTitle, design: .monospaced))
                        .bold()
                    Spacer()
                }
            }
        }
    }
}

#if DEBUG
struct EquationView_Previews: PreviewProvider {
    static var previews: some View {
        EquationView()
            .environmentObject(Processor())
            .padding()
    }
}
#endif
