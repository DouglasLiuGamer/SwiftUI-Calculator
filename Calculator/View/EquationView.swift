//
//  EquationView.swift
//  Calculator
//
//  Created by Douglas Liu on 27/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct EquationView: View {
    var body: some View {
        var equation = Text("")
        let maxLength = 20
        var length = 0

        for token in processor.tokens {
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

        for _ in 0..<processor.parenUnmatched {
            if length + 1 > maxLength {
                length = 0
                equation = equation + Text("\n)")
                    .foregroundColor(tokenColor(.rparen).opacity(0.4))
            } else {
                equation = equation + Text(")")
                    .foregroundColor(tokenColor(.rparen).opacity(0.4))
            }

            length += 1
        }

        return equation
            .font(.system(size: 22, weight: .semibold, design: .monospaced))
            .opacity(processor.ans == nil ? 1 : 0.4)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @EnvironmentObject private var processor: Processor

    private func tokenColor(_ type: Token.TokenType) -> Color {
        switch type {
        case .number, .ans:
            return Color("Operand")
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
        let processor = Processor()
        processor.tokens = [
            Token(type: .number, value: "1234"),
            Token(type: .opt, value: "+"),
            Token(type: .lparen, value: "("),
            Token(type: .number, value: "123456"),
            Token(type: .opt, value: "+"),
            Token(type: .number, value: "12345678901234567890")
        ]
        processor.parenUnmatched = 1

        return EquationView()
            .environmentObject(processor)
            .previewLayout(.sizeThatFits)
    }
}
#endif
