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
        let entry = SimpleEntry(date: Date(), selected: 1)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> ()) {
        var entries = [SimpleEntry]()
        
        for i in 0...3 {
            let components = DateComponents(second: i)
            let entryDate = Calendar.current.date(byAdding: components, to: Date())!
            let entry = SimpleEntry(date: entryDate, selected: i)
            
            entries.append(entry)
        }
        
        let secondComponents = DateComponents(second: 1)
        let reloadDate = Calendar.current.date(byAdding: secondComponents, to: Date())!
        let timeline = Timeline(entries: entries, policy: .after(reloadDate))
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
        HStack {
            Image("PlayerMove\(entry.selected)")
                .resizable()
                .scaledToFit()
            
            Text(entry.selected.description)
//            Text(entry.date.formatted(date: .omitted, time: .standard))
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
        .supportedFamilies([.accessoryRectangular])
    }
}

//struct AnimatedWidgetEx_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimatedWidgetExEntryView(entry: SimpleEntry(selected: 3))
//            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
//    }
//}
