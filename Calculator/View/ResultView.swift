//
//  ResultView.swift
//  Calculator
//
//  Created by Douglas Liu on 28/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        var text = ""

        if let result = processor.ans {
            text = String(format: "%.\(processor.precision)f", result)

            if result.isNaN {
                text = "NaN"
            } else if result.isInfinite {
                text = text.replacingOccurrences(
                    of: "inf",
                    with: "INFINITY"
                )
            } else {
                while text.last == "0" {
                    text.removeLast()
                }
                if text.last == "." {
                    text.removeLast()
                }
            }
        }

        return Text(text)
            .font(Font.system(size: 35, weight: .bold, design: .monospaced))
            .foregroundColor(Color("Operand"))
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @EnvironmentObject private var processor: Processor
}

#if DEBUG
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let processor = Processor()
        processor.ans = 123.45678
        processor.precision = 4

        return ResultView()
            .environmentObject(processor)
            .previewLayout(.sizeThatFits)
    }
}
#endif
