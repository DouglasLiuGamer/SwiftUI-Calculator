//
//  Equation.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

class Token {
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
    @Published var equation = ""

    func receive(symbol: String) {
        // The reveived symbol must be valid, since invalid buttons are disabled
        switch symbol {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            clearIfAns()
            if tokens.last?.type == .number {
                tokens.last!.value.append(symbol)
            } else {
                tokens.append(Token(type: .number, value: symbol))
            }
        case ".":
            clearIfAns()
            if tokens.last?.type == .number {
                tokens.last!.value.append(symbol)
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

            tokens.last?.value.removeLast()

            if tokens.last?.type == .lparen {
                parenUnmatched -= 1
            }
            if tokens.last?.type == .rparen {
                parenUnmatched += 1
            }

            if tokens.last?.value.isEmpty ?? false || tokens.last?.type == .ans {
                tokens.removeLast()
            }
        case "=":
            eval()
        default:
            break
        }

        // TODO: Fancy output later
        equation = ""
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
                return ans == "INFINITY" || ans == "-INFINITY" || ans == "ERROR"
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
            }
        case "-":
            return false
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
            }
        case "<":
            return tokens.isEmpty
        case "=":
            return parenUnmatched != 0
                || !ans.isEmpty
                || tokens.isEmpty
                || tokens.last?.type == .opt
        default:
            return true
        }
    }

    private var tokens: [Token] = []
    private var parenUnmatched: Int = 0

    private func clearIfAns() {
        if !ans.isEmpty {
            if ans == "INFINITY" || ans == "-INFINITY" || ans == "ERROR" {
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
        } else {
            ans = "ERROR"
        }
    }
}
