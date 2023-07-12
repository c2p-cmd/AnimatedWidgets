//
//  ContentView.swift
//  AnimatedWidgets
//
//  Created by Sharan Thakur on 12/07/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    private let gifs = 0...39
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    
    @State private var selected = 00
    
    var body: some View {
        VStack {
            Image("frame_\(selected)_delay-0.03s", bundle: .main)
        }
        .padding()
        .onReceive(timer) { _ in
            if selected >= 39 {
                selected = 0
            }
            selected += 1
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
