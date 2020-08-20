//
//  GlobalEnvironment.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/19.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class GlobalEnvironment: ObservableObject {

    @Published var display: String = "0"
    private var calculateStatus: CalculateStatus = .none
    private var preVal: String = ""
    private var curVal: String = ""

    enum CalculateStatus {
        case none, plus, minus, multiple, divide, reverse, percent, tax
    }

    func receiveInput(button: CalculatorButton) {

        let button = button.title

        switch calculateStatus {
        case .none:
            handleFisrstNumberSelected(value: button)
        case .plus, .minus, .multiple, .divide, .reverse, .percent, .tax:
            handleSecondNumberSelected(value: button)
        }
    }

    private func clear() {
        preVal = ""
        curVal = ""
        display = "0"
        calculateStatus = .none
    }


    private func handleFisrstNumberSelected(value: String) {

        switch value {
        case "0"..."9":
            preVal += value
            display = preVal
            if preVal.hasPrefix("0") {
                preVal = ""
            }
        case ".":
            if !confirmIncludeDecimalPoint(numberString: preVal) {
                preVal += value
                display = preVal
            }
        case "+":
            calculateStatus = .plus
        case "-":
            calculateStatus = .minus
        case "×":
            calculateStatus = .multiple
        case "÷":
            calculateStatus = .divide
        case "+/-":
            calculateStatus = .reverse
            calculateResultNumber()
        case "%":
            calculateStatus = .percent
            calculateResultNumber()
        case "$":
            calculateStatus = .tax
            calculateResultNumber()
        case "AC":
            clear()
        default:
            break
        }

    }

    private func handleSecondNumberSelected(value: String) {
        switch value {
        case "0"..."9":
            curVal += value
            display = curVal
            if curVal.hasPrefix("0") {
                curVal = ""
            }
        case ".":
            if !confirmIncludeDecimalPoint(numberString: curVal) {
                curVal += value
                display = curVal
            }
        case "=":
            calculateResultNumber()
            calculateStatus = .none
        case "+":
            calculateResultNumber()
            calculateStatus = .plus
        case "-":
            calculateResultNumber()
            calculateStatus = .minus
        case "÷":
            calculateResultNumber()
            calculateStatus = .divide
        case "×":
            calculateResultNumber()
            calculateStatus = .multiple
        case "$":
            calculateStatus = .tax
            calculateResultNumber()
        case "+/-":
            calculateStatus = .reverse
            calculateResultNumber()
        case "%":
            calculateStatus = .percent
            calculateResultNumber()
        case "AC":
            clear()
        default:
            break
        }
    }

    private func calculateResultNumber() {

        guard let preValue = Double(preVal), let curValue = Double(curVal) else { return }

        var resultString: String?
        switch calculateStatus {
        case .plus:
            resultString = String(preValue + curValue)
        case .minus:
            resultString = String(preValue - curValue)
        case .multiple:
            resultString = String(preValue * curValue)
        case .divide:
            resultString = String(preValue / curValue)
        case .reverse:
            resultString = String(preValue * -1)
        case .percent:
            resultString = String(preValue / 100)
        case .tax:
            resultString = String(preValue * 1.1)
        default:
            break
        }

        if let result = resultString, result.hasPrefix("0") {
            resultString = result.replacingOccurrences(of: "0", with: "")
        }

        display = resultString ?? "0"
        preVal = ""
        curVal = ""

        preVal += resultString ?? ""
        calculateStatus = .none
    }

    private func confirmIncludeDecimalPoint(numberString: String) -> Bool {
        if numberString.range(of: ".") != nil || numberString.count == 0 {
            return true
        } else {
            return false
        }
    }


}
