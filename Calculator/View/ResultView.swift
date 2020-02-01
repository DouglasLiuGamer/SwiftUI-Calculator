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
        var display = Text("")

        if let result = processor.ans {
            if result.isNaN || result.isInfinite {
                display = Text("ERROR")
            } else {
                var text = String(format: "%.\(processor.precision)f", result)

                while text.last == "0" {
                    text.removeLast()
                }
                if text.last == "." {
                    text.removeLast()
                }

                display = Text(text)
            }
        }

        return display
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
