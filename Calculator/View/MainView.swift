//
//  MainView.swift
//  Calculator
//
//  Created by Douglas Liu on 29/12/2019.
//  Copyright © 2019 Douglas Liu. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack() {
                ScreenView()
                    .padding([.horizontal, .top])

                Divider()
                    .padding(.horizontal)

                PadView()
                    .frame(height: geometry.size.height * 0.6)
                    .padding()
            }
            .accentColor(Color("Accent"))
        }
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Processor())
    }
}
#endif
