//
//  SwiftUIView.swift
//  SwiftFood
//
//  Created by Jacob Christie on 2020-02-05.
//  Copyright © 2020 Loop Software Inc. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    var progress: Binding<CGFloat>

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: geometry.size.width, height: 2)
                Capsule()
                    .frame(width: geometry.size.width * self.progress.wrappedValue, height: 2)
                    .foregroundColor(.pink)

            }
        }
    }
}
struct SearchCell: View {
    var item: Item

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Artist")
                Text("Album")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Button(action: {
//                withAnimation {
                    self.item.isDownloading = true
//                }
                print("x")
            }) { Image(systemName: "icloud.and.arrow.down") }
                .foregroundColor(.blue)
        }
    }
}

struct DownloadingCell: View {
    var item: Item

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Artist")
                    Text("Album")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }

                Spacer()

                HStack {
                    Button(action:  {
                        self.item.isDownloading = false
                    }) { Image(systemName: "x.circle").imageScale(.large)}
                    Button(action: { print("pause.circle") }) {
                        Image(systemName: "pause.circle").imageScale(.large) }
                }
                .foregroundColor(.blue)

            }

            HStack {
                ProgressView(progress: .constant(0.4))
                    .animation(.default)
                Text("progress")
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
    }
}

struct Cell: View {
    @ObservedObject var item: Item

    var body: some View {
        if item.isDownloading {
            return AnyView(DownloadingCell(item: item))
        } else {
            return AnyView(SearchCell(item: item))
        }
    }
}

class Item: Identifiable, ObservableObject {
    var id = UUID()
    @Published var isDownloading = false
}


struct SwiftUIView: View {
    @State var items: [Item] = (1...20).map { _ in Item() }

    var body: some View {
        List(items, rowContent: Cell.init)
            .buttonStyle(BorderlessButtonStyle())
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
