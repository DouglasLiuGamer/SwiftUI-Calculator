//
//  AnsView.swift
//  Calculator
//
//  Created by Douglas Liu on 28/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct AnsView: View {
    var ans: Double?
    var precision: Int

    var body: some View {
        var display = Text(" ")

        if let ans = ans {
            display = Text("ANS=")

            var text = String(format: "%.\(precision)f", ans)
            while text.last == "0" {
                text.removeLast()
            }
            if text.last == "." {
                text.removeLast()
            }

            display = display + Text(text)
        }

        return display
            .font(Font.system(size: 22, weight: .regular, design: .monospaced))
            .lineLimit(1)
            .padding(.trailing)
            .padding(.trailing)
    }
}

#if DEBUG
struct AnsView_Previews: PreviewProvider {
    static var previews: some View {
        AnsView(ans: 123.12345, precision: 4)
    }
}
#endif
