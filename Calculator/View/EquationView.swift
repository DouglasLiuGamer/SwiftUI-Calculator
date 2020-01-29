//
//  EquationView.swift
//  Calculator
//
//  Created by Douglas Liu on 27/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct EquationView: View {
    var tokens: [Token]
    var dimmed: Bool

    var body: some View {
        let maxLength = 20
        var length = 0

        var equation = Text("")
        for token in tokens {
            var text = ""

            if length + token.value.count > maxLength {
                if length > 0 {
                    text = "\n"
                }

                var begin = token.value.startIndex
                var end = begin
                length = token.value.count

                while length > maxLength {
                    begin = end
                    end = token.value.index(begin, offsetBy: maxLength)
                    text += "\(token.value[begin..<end])\n"

                    length -= maxLength
                }

                if length > 0 {
                    text += "\(token.value[end..<token.value.endIndex])"
                }
            } else {
                text = token.value
                length += text.count
            }

            equation = equation + Text(text)
                .foregroundColor(tokenColor(token.type))
        }

        return equation
            .font(.system(size: 22, weight: .semibold, design: .monospaced))
            .opacity(dimmed ? 0.4 : 1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func tokenColor(_ type: Token.TokenType) -> Color {
        switch type {
        case .number, .ans:
            return Color("Text")
        case .opt:
            return Color("Operator")
        case .lparen, .rparen:
            return Color("Parentheses")
        }
    }
}

#if DEBUG
struct Equation_Previews: PreviewProvider {
    static var previews: some View {
        EquationView(tokens: [
            Token(type: .number, value: "1234"),
            Token(type: .opt, value: "+"),
            Token(type: .number, value: "123456"),
            Token(type: .opt, value: "+"),
            Token(type: .number, value: "12345678901234567890")
            ],
            dimmed: true
        )
            .previewLayout(.sizeThatFits)
    }
}
#endif
