//
//  ContentView.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

enum  CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide, tax
    case decimal
    case ac, plusminus, percent

    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .decimal: return "."
        case .equals: return "="
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .tax: return "$"
        case .ac: return "AC"
        case .plusminus: return "+/-"
        case .percent: return "%"
        }
    }

    var fontColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal, .equals, .plus, .minus, .multiply, .divide, .tax:
            return Color.white
        case .ac, .plusminus, .percent:
            return Color.black
        }
    }

    var fontSize: CGFloat {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return 18
        case .equals, .plus, .minus, .multiply, .divide:
            return 24
        case .ac, .plusminus, .percent, .tax:
            return 15
        }
    }

    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(UIColor.darkGray)
        case .equals, .plus, .minus, .multiply, .divide, .tax:
            return Color.orange
        case .ac, .plusminus, .percent:
            return Color(UIColor.lightGray)
        }
    }

}

class GlobalEnvironment: ObservableObject {

    @Published var display: String = "37436"

    func receiveInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }

}

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

    var button: CalculatorButton

    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        Button(action: {
            self.env.receiveInput(calculatorButton: self.button)
        }) {
            Text(button.title)
                .font(.system(size: button.fontSize))
                .foregroundColor(button.fontColor)
        }
        .frame(width: self.buttonWidth(), height: self.buttonHeight())
        .background(button.backgroundColor)
        .cornerRadius(15)
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
