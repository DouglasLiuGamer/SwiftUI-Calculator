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
    @Published var prevAns = ""
    @Published var ans = ""
    @Published var tokens: [Token] = []

    // Delete later
    var equation = ""

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
            if !ans.isEmpty {
                ans.removeAll()
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

        // TODO: Fancy output later
        equation.removeAll()
        for token in tokens {
            equation.append(token.value)
        }
    }

    func isDisabled(symbol: String) -> Bool {
        switch symbol {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            if !ans.isEmpty {
                return false
            } else {
                return tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case ".":
            if !ans.isEmpty {
                return false
            } else {
                return tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
                    || tokens.last?.type == .number && tokens.last!.value.contains(".")
            }
        case "ANS":
            if !ans.isEmpty {
                return ans == "INFINITY" || ans == "-INFINITY" || ans == "NaN"
            } else {
                return prevAns.isEmpty
                    || tokens.last?.type == .number
                    || tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case "+", "⨯", "÷":
            if !ans.isEmpty {
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
            if !ans.isEmpty {
                return false
            } else {
                return tokens.last?.type == .number
                    || tokens.last?.type == .ans
                    || tokens.last?.type == .rparen
            }
        case ")":
            if !ans.isEmpty {
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
                || !ans.isEmpty
                || tokens.isEmpty
                || tokens.last?.type == .opt
                || tokens.last?.type == .number && tokens.last!.value.last! == "."
        default:
            return true
        }
    }

    func resetEquation() {
        ans.removeAll()
        equation.removeAll()

        tokens.removeAll()
        parenUnmatched = 0
    }

    private var parenUnmatched: Int = 0

    private func clearIfAns() {
        if !ans.isEmpty {
            if ans == "INFINITY" || ans == "-INFINITY" || ans == "NaN" {
                prevAns.removeAll()
            } else {
                prevAns = ans
            }
            ans.removeAll()
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
                s.append(prevAns)
                if !prevAns.contains(".") {
                    s.append(".0")
                }
            } else if token.value == "⨯" {
                s.append("*")
            } else if token.value == "÷" {
                s.append("/")
            } else {
                s.append(token.value)
            }
        }

        let expr = NSExpression(format: s)
        if let result = expr.expressionValue(with: nil, context: nil) as? Double {
            ans = String(result)
                .replacingOccurrences(of: "inf", with: "INFINITY")
                .replacingOccurrences(of: "nan", with: "NaN")
        } else {
            // TODO: Issue an alert and clear.
            ans = "ERROR"
        }
    }
}
