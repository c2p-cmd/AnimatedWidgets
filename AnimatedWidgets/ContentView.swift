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
                    .background(.white)
            }
            
            Button {
                WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
            } label: {
                Text("Reload")
            }

        }
        .padding()
        .onAppear {
            loadImage { newImage in
                self.uiImage = newImage
            }
        }
        .onChange(of: picketItem) { value in
            value?.loadTransferable(type: Data.self) { (result) in
                switch result {
                case .success(let data):
                    if let data {
                        if let image = UIImage(data: data, scale: 0.5) {
                            saveImage(image)
                        } else {
                            print("Issue")
                        }
                        loadImage { newImage in
                            self.uiImage = newImage
                        }
                        WidgetCenter.shared.reloadTimelines(ofKind: "MyWidget")
                    } else {
                        print("No data")
                    }
                    break
                case .failure(let err):
                    print(err.localizedDescription)
                    break
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
