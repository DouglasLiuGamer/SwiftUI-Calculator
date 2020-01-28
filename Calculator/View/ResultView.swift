//
//  ResultView.swift
//  Calculator
//
//  Created by Douglas Liu on 28/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct ResultView: View {
    var result: Double?
    var precision: Int

    var body: some View {
        var text = ""

        if let result = result {
            text = String(format: "%.\(precision)f", result)

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
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(result: -1.245875e+1, precision: 4)
    }
}
#endif
