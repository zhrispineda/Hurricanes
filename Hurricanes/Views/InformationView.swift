//
//  InformationView.swift
//  Hurricanes
//

import SwiftUI
import AVKit

struct InformationView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VideoPlayer(player: AVPlayer(url: URL(string: "https://cdn.oceanservice.noaa.gov/oceanserviceprod/facts/hurricanes-of.mp4")!))
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    Text("A hurricane is a type of storm called a tropical cyclone, which forms over tropical or subtropical waters.")
                } header: {
                    Text("What is a Hurricane?")
                } footer: {
                    Text("[Source: NOAA](https://oceanservice.noaa.gov/facts/hurricane.html)")
                }
            }
            .navigationTitle("Information")
        }
    }
}

#Preview {
    InformationView()
}
