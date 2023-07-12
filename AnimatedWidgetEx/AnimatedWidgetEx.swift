//
//  AnimatedWidgetEx.swift
//  AnimatedWidgetEx
//
//  Created by Sharan Thakur on 12/07/23.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), selected: 10)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries = [SimpleEntry]()
        
        for i in 0...40 {
            let components = DateComponents(second: i)
            let entryDate = Calendar.current.date(byAdding: components, to: Date())!
            let entry = SimpleEntry(date: entryDate, selected: i)
            
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date = .now
    var selected = 0
}

struct AnimatedWidgetExEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image("frame_\(entry.selected)_delay-0.03s")
                .resizable()
                .scaledToFit()
            
            Text(entry.selected.description)
            Text(entry.date.formatted(date: .omitted, time: .standard))
        }.padding()
    }
}

struct AnimatedWidgetEx: Widget {
    let kind: String = "AnimatedWidgetEx"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            AnimatedWidgetExEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

//struct AnimatedWidgetEx_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedWidgetExEntryView(entry: SimpleEntry(selected: 3))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}
