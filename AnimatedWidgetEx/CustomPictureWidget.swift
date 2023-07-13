//
//  CustomPictureWidget.swift
//  AnimatedWidgetExExtension
//
//  Created by Sharan Thakur on 13/07/23.
//

import SwiftUI
import WidgetKit

struct PictureEntry: TimelineEntry {
    var date: Date = .now
    var uiImage: UIImage = UIImage(named: "frame_40_delay-0.03s")!
}

struct PictureTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> PictureEntry {
        PictureEntry()
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PictureEntry) -> Void) {
        var entry = PictureEntry()
        
        loadImage { newImage in
            entry.uiImage = newImage
        } onError: { oldImage in
            entry.uiImage = oldImage
        }
        
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<PictureEntry>) -> Void) {
        getSnapshot(in: context) { pictureEntry in
            let timeline = Timeline(entries: [pictureEntry], policy: .atEnd)
            
            completion(timeline)
        }
    }
}

struct PictureEntryView: View {
    var entry: PictureEntry
    
    var body: some View {
        VStack {
            Image(uiImage: entry.uiImage)
                .resizable()
                .scaledToFit()
        }.background(.gray)
    }
}

struct PictureWidget: Widget {
    let kind = "MyWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: PictureTimelineProvider()
        ) { entry in
            PictureEntryView(entry: entry)
        }
        .configurationDisplayName("Custom Picture Widget")
        .description("Show your own picture")
    }
}
