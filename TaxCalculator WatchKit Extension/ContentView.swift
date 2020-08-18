//
//  ContentView.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var result: Int = 0
    let buttons = [
        ["AC", "±", "%", "÷"],
        ["7", "8", "9", "×"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "TIP", "="]
    ]



    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Spacer()
                HStack {
                    Text("3746")
                        .font(.system(size: 25))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 10)
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {
                                print(button)
                            }) {
                                Text(button)
                                    .font(.system(size: 18))
                                    .scaledToFill()
                            }
                            .frame(width: 37, height: 24)
                            .background(Color.orange)
                            .cornerRadius(12)
                            .padding(1)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
