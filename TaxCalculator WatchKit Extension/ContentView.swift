//
//  ContentView.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var env: GlobalEnvironment

    private let buttons: [[CalculatorButton]] = [
        [.ac, .plusminus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .tax, .equals]
    ]

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Text(env.display)
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 10)
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }
                }
            }
        }
    }

}

struct CalculatorButtonView: View {

    @State private var scale: CGFloat = 1.0
    var button: CalculatorButton


    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        Button(action: {
            self.env.receiveInput(button: self.button)
            self.scale = 1.2
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) {_ in
                self.scale = 1.0
            }
        }) {
            Text(button.title)
                .font(.system(size: button.fontSize))
                .foregroundColor(button.fontColor)
        }
        .frame(width: self.buttonWidth(), height: self.buttonHeight())
        .background(button.backgroundColor)
        .cornerRadius(15)
        .scaleEffect(scale)
        .padding(1)
    }

    private func buttonWidth() -> CGFloat {
        let currentDevice = WKInterfaceDevice.current()
        let bounds = currentDevice.screenBounds
        return (bounds.width - 15) / 4
    }

    private func buttonHeight() -> CGFloat {
        let currentDevice = WKInterfaceDevice.current()
        let bounds = currentDevice.screenBounds
        return (bounds.height) / 8
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
