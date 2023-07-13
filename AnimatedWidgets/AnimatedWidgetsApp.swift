//
//  AnimatedWidgetsApp.swift
//  AnimatedWidgets
//
//  Created by Sharan Thakur on 12/07/23.
//

import SwiftUI

@main
struct AnimatedWidgetsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .defaultAppStorage(ourStore)
        }
    }
}
