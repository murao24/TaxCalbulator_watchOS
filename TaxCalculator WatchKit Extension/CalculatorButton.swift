//
//  CalculatorButton.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/19.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
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
