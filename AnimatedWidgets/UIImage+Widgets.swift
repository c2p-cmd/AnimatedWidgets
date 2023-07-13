//
//  UIImage+Widgets.swift
//  AnimatedWidgets
//
//  Created by Sharan Thakur on 13/07/23.
//

import UIKit

let ourStore = UserDefaults(suiteName: "group.com.kidastudios.mygroup")!

func saveImage(_ image: UIImage) {
    guard let data = image.jpegData(compressionQuality: 0.5) else { return }
    let encoded = try! PropertyListEncoder().encode(data)
    ourStore.set(encoded, forKey: "KEY")
}

func loadImage(
    newImage: ((UIImage) -> Void)?,
    onError: ((UIImage) -> Void)?
) {
    guard let data = ourStore.data(forKey: "KEY") else {
        onError?(UIImage(named: "frame_40_delay-0.03s")!)
        return
    }
    let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
    if let image = UIImage(data: decoded) {
        newImage?(image)
    } else {
        onError?(UIImage(named: "frame_40_delay-0.03s")!)
    }
}
