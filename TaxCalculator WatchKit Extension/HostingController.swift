//
//  HostingController.swift
//  TaxCalculator WatchKit Extension
//
//  Created by 村尾慶伸 on 2020/08/18.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    override var body: AnyView {
        return AnyView(ContentView().environmentObject(GlobalEnvironment()))
    }
}
