//
//  SatellitesView.swift
//  Hurricanes
//

import SwiftUI
import os

struct SatellitesView: View {
    // Variables
    @Environment(\.openURL) var openURL
    let hurricanesHelper = HurricanesHelper()
    let logger = Logger(subsystem: "Hurricanes", category: "SatellitesView")
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    AsyncImage(url: URL(string: "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/1800x1080.jpg")) { status in
                        switch status {
                        case .failure:
                            Text("Could not load image.")
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .contextMenu {
                                    Button {
                                        Task {
                                            if let uiImage = await hurricanesHelper.getImage(from: "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/1800x1080.jpg") {
                                                UIPasteboard.general.image = uiImage
                                            }
                                        }
                                    } label: {
                                        Label("Copy", systemImage: "doc.on.doc")
                                    }
                                    Button {
                                        openURL(URL(string: "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/GOES16-TAW-GEOCOLOR-900x540.gif")!)
                                    } label: {
                                        Label("Open GIF", systemImage: "photo")
                                    }
                                }
                        default:
                            ProgressView()
                        }
                    }
                } header: {
                    Text("GEOCOLOR")
                }
                .sectionHeaderStyle()
            }
            .navigationTitle("Satellites")
            .listStyle(.inset)
        }
    }
}

#Preview {
    SatellitesView()
}
