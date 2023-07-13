//
//  ContentView.swift
//  AnimatedWidgets
//
//  Created by Sharan Thakur on 12/07/23.
//

import SwiftUI
import Foundation
import UIKit
import PhotosUI
import WidgetKit

struct ContentView: View {
    @State private var uiImage: UIImage? = UIImage(named: "frame_40_delay-0.03s")
    @State private var picketItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            PhotosPicker("Choose your image", selection: self.$picketItem, matching: .images)
            
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        }
        .padding()
        .onChange(of: picketItem) { _ in
            Task {
                if let data = try? await picketItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        saveImage(uiImage)
                        self.uiImage = uiImage
                        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
                        return
                    }
                }
                
                print("Failed")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
