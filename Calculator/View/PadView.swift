//
//  PadView.swift
//  Calculator
//
//  Created by Douglas Liu on 1/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct PadView: View {
    @EnvironmentObject var processor: Processor

    var body: some View {
        VStack {
            HStack {
                TextButton(
                    symbol: "ANS",
                    disabled: processor.isDisabled(symbol: "ANS")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "ANS"))
                )

                TextButton(
                    symbol: "(",
                    disabled: processor.isDisabled(symbol: "(")
                ).buttonStyle(
                    ParenButtonStyle(disabled: processor.isDisabled(symbol: "("))
                )

                TextButton(
                    symbol: ")",
                    disabled: processor.isDisabled(symbol: ")")
                ).buttonStyle(
                    ParenButtonStyle(disabled: processor.isDisabled(symbol: ")"))
                )

                ImageButton(
                    symbol: "÷",
                    imageName: "divide",
                    disabled: processor.isDisabled(symbol: "÷")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "÷"))
                )
            }
            HStack {
                TextButton(
                    symbol: "7",
                    disabled: processor.isDisabled(symbol: "7")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "7"))
                )

                TextButton(
                    symbol: "8",
                    disabled: processor.isDisabled(symbol: "8")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "8"))
                )

                TextButton(
                    symbol: "9",
                    disabled: processor.isDisabled(symbol: "9")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "9"))
                )

                ImageButton(
                    symbol: "⨯",
                    imageName: "multiply",
                    disabled: processor.isDisabled(symbol: "⨯")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "⨯"))
                )
            }
            HStack {
                TextButton(
                    symbol: "4",
                    disabled: processor.isDisabled(symbol: "4")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "4"))
                )

                TextButton(
                    symbol: "5",
                    disabled: processor.isDisabled(symbol: "5")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "5"))
                )

                TextButton(
                    symbol: "6",
                    disabled: processor.isDisabled(symbol: "6")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "6"))
                )

                ImageButton(
                    symbol: "-",
                    imageName: "minus",
                    disabled: processor.isDisabled(symbol: "-")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "-"))
                )
            }
            HStack {
                TextButton(
                    symbol: "1",
                    disabled: processor.isDisabled(symbol: "1")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "1"))
                )

                TextButton(
                    symbol: "2",
                    disabled: processor.isDisabled(symbol: "2")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "2"))
                )

                TextButton(
                    symbol: "3",
                    disabled: processor.isDisabled(symbol: "3")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "3"))
                )

                ImageButton(
                    symbol: "+",
                    imageName: "plus",
                    disabled: processor.isDisabled(symbol: "+")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "+"))
                )
            }
            HStack {
                TextButton(
                    symbol: "0",
                    disabled: processor.isDisabled(symbol: "0")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "0"))
                )

                TextButton(
                    symbol: ".",
                    disabled: processor.isDisabled(symbol: ".")
                ).buttonStyle(
                    OperantButtonStyle(disabled: processor.isDisabled(symbol: "."))
                )

                ImageButton(
                    symbol: "<",
                    imageName: "delete.left",
                    disabled: processor.isDisabled(symbol: "<")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "<"))
                )

                ImageButton(
                    symbol: "=",
                    imageName: "equal",
                    disabled: processor.isDisabled(symbol: "=")
                ).buttonStyle(
                    OperatorButtonStyle(disabled: processor.isDisabled(symbol: "="))
                )
            }
        }
    }
}

#if DEBUG
struct PadView_Previews: PreviewProvider {
    static var previews: some View {
        PadView().environmentObject(Processor())
    }
}
#endif
