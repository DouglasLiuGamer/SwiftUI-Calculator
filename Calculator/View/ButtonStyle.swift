//
//  ButtonStyle.swift
//  Calculator
//
//  Created by Douglas Liu on 1/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct OperantButtonStyle: ButtonStyle {
    var disabled: Bool

    func makeBody(configuration: OperantButtonStyle.Configuration) -> some View {
        configuration.label
            .overlay(Circle().stroke())
            .padding(4)
            .overlay(Circle().stroke())
            .foregroundColor(Color("Text"))
            .contentShape(Circle())
            .opacity(disabled ? 0.4 : 1)
            .scaleEffect(configuration.isPressed && !disabled ? 0.9 : 1)
    }
}

struct ParenButtonStyle: ButtonStyle {
    var disabled: Bool

    func makeBody(configuration: ParenButtonStyle.Configuration) -> some View {
        configuration.label
            .overlay(Circle().stroke())
            .padding(4)
            .overlay(Circle().stroke())
            .foregroundColor(Color("Parentheses"))
            .contentShape(Circle())
            .opacity(disabled ? 0.4 : 1)
            .scaleEffect(configuration.isPressed && !disabled ? 0.9 : 1)
    }
}

struct OperatorButtonStyle: ButtonStyle {
    var disabled: Bool

    func makeBody(configuration: OperatorButtonStyle.Configuration) -> some View {
        configuration.label
            .overlay(Circle().stroke())
            .padding(4)
            .overlay(Circle().stroke())
            .foregroundColor(Color("Operator"))
            .contentShape(Circle())
            .opacity(disabled ? 0.4 : 1)
            .scaleEffect(configuration.isPressed && !disabled ? 0.9 : 1)
    }
}
