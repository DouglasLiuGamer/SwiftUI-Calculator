//
//  Processor.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

struct Token {
    enum TokenType {
        case number, ans, opt, lparen, rparen
    }

    var type: TokenType
    var value: String

    init(type: TokenType, value: String) {
        self.type = type
        self.value = value
    }
}

class Processor: ObservableObject {
    @Published var precision = UserDefaults.standard.integer(forKey: "Precision")
    @Published var allowVibration = UserDefaults.standard.bool(forKey: "Vibration")

    @Published var prevAns: Double? = nil
    @Published var ans: Double? = nil
    @Published var tokens: [Token] = []

    func receive(symbol: String) {
        // The reveived symbol must be valid, since invalid buttons are disabled
        switch symbol {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            clearIfAns()
            if tokens.last?.type == .number {
                var token = tokens.popLast()!
                token.value.append(symbol)
                tokens.append(token)
            } else {
                tokens.append(Token(type: .number, value: symbol))
            }
        case ".":
            clearIfAns()
            if tokens.last?.type == .number {
                var token = tokens.popLast()!
                token.value.append(symbol)
                tokens.append(token)
            } else {
                tokens.append(Token(type: .number, value: symbol))
            }
        case "ANS":
            clearIfAns()
            tokens.append(Token(type: .ans, value: symbol))
        case "+", "-", "⨯", "÷":
            clearIfAns()
            tokens.append(Token(type: .opt, value: symbol))
        case "(":
            clearIfAns()
            parenUnmatched += 1
            tokens.append(Token(type: .lparen, value: symbol))
        case ")":
            parenUnmatched -= 1
            tokens.append(Token(type: .rparen, value: symbol))
        case "<":
            if ans != nil {
                ans = nil
                break
            }

            var token = tokens.popLast()!
            token.value.removeLast()

            if token.type == .lparen {
                parenUnmatched -= 1
            }
            if token.type == .rparen {
                parenUnmatched += 1
            }

            if token.type != .ans && !token.value.isEmpty {
                tokens.append(token)
            }
        case "=":
            eval()
        default:
            break
        }
    }

    func isDisabled(symbol: String) -> Bool {
        switch symbol {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if ans != nil {
                return false
            } else {
                return tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case ".":
            if ans != nil {
                return false
            } else {
                return tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
                    || tokens.last?.type == .number && tokens.last!.value.contains(".")
            }
        case "ANS":
            if ans != nil {
                return ans!.isNaN || ans!.isInfinite
            } else {
                return prevAns == nil
                    || tokens.last?.type == .number
                    || tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case "+", "⨯", "÷":
            if ans != nil {
                return true
            } else {
                return tokens.isEmpty
                    || tokens.last?.type == .opt
                    || tokens.last?.type == .lparen
                    || tokens.last?.type == .number && tokens.last!.value.last! == "."
            }
        case "-":
            return tokens.last?.type == .number && tokens.last!.value.last! == "."
        case "(":
            if ans != nil {
                return false
            } else {
                return tokens.last?.type == .number
                    || tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case ")":
            if ans != nil {
                return true
            } else {
                return parenUnmatched == 0
                    || tokens.last?.type == .opt
                    || tokens.last?.type == .lparen
                    || tokens.last?.type == .number && tokens.last!.value.last! == "."
            }
        case "<":
            return tokens.isEmpty
        case "=":
            return parenUnmatched != 0
                || ans != nil
                || tokens.isEmpty
                || tokens.last?.type == .opt
                || tokens.last?.type == .number && tokens.last!.value.last! == "."
        default:
            return true
        }
    }

    func resetEquation() {
        ans = nil
        tokens.removeAll()
        parenUnmatched = 0
    }

    private var parenUnmatched: Int = 0

    private func clearIfAns() {
        if ans != nil {
            if ans!.isNaN || ans!.isInfinite {
                prevAns = nil
            } else {
                prevAns = ans
            }
            ans = nil
            tokens.removeAll()
        }
    }

    private func eval() {
        var s = ""
        for token in tokens {
            if token.type == .number && !token.value.contains(".") {
                s.append(token.value)
                s.append(".0")
            } else if token.type == .ans {
                s.append(String(prevAns!))
            } else if token.value == "⨯" {
                s.append("*")
            } else if token.value == "÷" {
                s.append("/")
            } else {
                s.append(token.value)
            }
        }

        let expr = NSExpression(format: s)
        ans = expr.expressionValue(with: nil, context: nil) as? Double
    }
}
