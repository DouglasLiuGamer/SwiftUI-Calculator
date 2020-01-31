//
//  SettingView.swift
//  Calculator
//
//  Created by Douglas Liu on 31/1/2020.
//  Copyright © 2020 Douglas Liu. All rights reserved.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundColor(Color("Accent"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)

            Toggle(isOn: $processor.allowVibration) {
                Text("Vibration")
                    .foregroundColor(Color("Accent"))
            }
            .padding(.bottom)


            Stepper(
                value: $processor.precision,
                in: 3...8
            ) {
                Text("Numeric Precision: \(processor.precision)")
                    .foregroundColor(Color("Accent"))
            }

            Spacer()

            Text("Swipe Down to Exit")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.bottom, 5)

            Image(systemName: "chevron.down")
                .foregroundColor(.gray)
        }
        .padding()
    }

    @EnvironmentObject private var processor: Processor
}

#if DEBUG
struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
            .environmentObject(Processor())
            .accentColor(Color("Accent"))
    }
}
#endif
