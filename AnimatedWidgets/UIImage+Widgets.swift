//
//  UIImage+Widgets.swift
//  AnimatedWidgets
//
//  Created by Sharan Thakur on 13/07/23.
//

import UIKit

let ourStore = UserDefaults(suiteName: "group.com.kidastudios.mygroup")!

extension UIImage {
    func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
        let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: canvas, format: format).image {
            _ in draw(in: CGRect(origin: .zero, size: canvas))
        }
    }
}

func saveImage(_ image: UIImage) {
    if image.size.width > 800 {
        let resizedImage = image.resized(toWidth: 800)
        if let pngData = resizedImage!.pngData() {
            ourStore.set(pngData, forKey: "KEY")
        } else {
            print("No png data")
        }
        return
    }
    if let pngData = image.pngData() {
        ourStore.set(pngData, forKey: "KEY")
    } else {
        print("No png data")
    }
}

func saveImage(from data: Data) {
    ourStore.set(data, forKey: "KEY")
}

func loadImage(
    newImage: @escaping (UIImage) -> Void
) {
    guard let data = ourStore.data(forKey: "KEY") else {
        print("Big problem")
        newImage(UIImage(systemName: "exclamationmark.triangle.fill")!)
        return
    }
    let uiImage = UIImage(data: data) ?? UIImage(systemName: "exclamationmark.triangle.fill")!
    print("Setting image: \(uiImage.debugDescription) from: \(data.debugDescription)")
    newImage(uiImage)
}

//func saveImage(_ image: UIImage) {
//    guard let data = image.jpegData(compressionQuality: 0.5) else {
//        print("No jpeg data")
//        return
//    }
//    let encoded = try! PropertyListEncoder().encode(data)
//    ourStore.set(encoded, forKey: "KEY")
//}

//func loadImage(
//    newImage: @escaping (UIImage) -> Void
//) {
//    guard let data = ourStore.data(forKey: "KEY") else {
//        newImage(UIImage(systemName: "exclamationmark.triangle.fill")!)
//        return
//    }
//    if let image = UIImage(data: data) {
//        newImage(image)
//        return
//    }
//    let decoded = try! PropertyListDecoder().decode(Data.self, from: data)
//    if let image = UIImage(data: decoded) {
//        newImage(image)
//    } else {
//        newImage(UIImage(systemName: "exclamationmark.triangle.fill")!)
//    }
//}
