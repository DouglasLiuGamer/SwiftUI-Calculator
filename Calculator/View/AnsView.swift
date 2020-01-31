//
//  AnsView.swift
//  Calculator
//
//  Created by Douglas Liu on 28/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct AnsView: View {
    var body: some View {
        var display = Text(" ")

        if let ans = processor.prevAns {
            display =
                Text("ANS").foregroundColor(Color("Operand"))
            +
                Text("=").foregroundColor(Color("Operator"))

            var text = String(format: "%.\(processor.precision)f", ans)
            while text.last == "0" {
                text.removeLast()
            }
            if text.last == "." {
                text.removeLast()
            }

            display = display + Text(text)
                .foregroundColor(Color("Operand"))
        }

        return display
            .font(Font.system(size: 22, weight: .semibold, design: .monospaced))
            .lineLimit(1)
            .opacity(processor.ans == nil ? 1 : 0.4)
            .padding(.trailing)
            .padding(.trailing)
    }

    @EnvironmentObject private var processor: Processor
}

#if DEBUG
struct AnsView_Previews: PreviewProvider {
    static var previews: some View {
        let processor = Processor()
        processor.prevAns = 123.12345
        processor.precision = 4

        return AnsView()
            .environmentObject(processor)
            .previewLayout(.sizeThatFits)
    }
}
#endif
