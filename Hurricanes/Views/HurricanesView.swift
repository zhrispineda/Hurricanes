//
//  HurricanesView.swift
//  Hurricanes
//

import SwiftUI
import os

struct HurricanesView: View {
    // Variables
    @State private var currentTab: Tab = .atlantic
    @State private var outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_atl_"
    @State private var queryParameters = ""
    @State private var outlookText = "Loading…"
    @State private var outlookExpanded = true
    let logger = Logger(subsystem: "Hurricanes", category: "HurricanesView")
    let hurricanesHelper = HurricanesHelper()
    
    enum Tab: String {
        case centralPacific = "Central Pacific"
        case easternPacific = "Eastern Pacific"
        case atlantic = "Atlantic"
    }
    
    var body: some View {
        NavigationStack {
            List {
                // Two-Day Weather Outlook
                Section("Two-Day Weather Outlook") {
                    AsyncImage(url: URL(string: outlookImage + "2d0.png")) { status in
                        switch status {
                        case .failure:
                            Text("Could not get \(currentTab.rawValue) Outlook image.")
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .contextMenu {
                                    Button {
                                        Task {
                                            if let uiImage = await hurricanesHelper.getImage(from: outlookImage + "2d0.png") {
                                                UIPasteboard.general.image = uiImage
                                            }
                                        }
                                    } label: {
                                        Label("Copy", systemImage: "doc.on.doc")
                                    }
                                }
                        default:
                            ProgressView()
                        }
                    }
                }
                
                // Seven-Day Weather Outlook
                Section("Seven-Day Weather Outlook") {
                    AsyncImage(url: URL(string: outlookImage + "7d0.png")) { status in
                        switch status {
                        case .failure:
                            Text("Could not get \(currentTab.rawValue) Outlook image.")
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 15.0))
                                .contextMenu {
                                    Button {
                                        Task {
                                            if let uiImage = await hurricanesHelper.getImage(from: outlookImage + "7d0.png") {
                                                UIPasteboard.general.image = uiImage
                                            }
                                        }
                                    } label: {
                                        Label("Copy", systemImage: "doc.on.doc")
                                    }
                                }
                        default:
                            ProgressView()
                        }
                    }
                }
                
                // Outlook Text
                Section {
                    DisclosureGroup("\(currentTab.rawValue) Tropical Weather Outlook", isExpanded: $outlookExpanded) {
                        Text(outlookText)
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                } header: {
                    Text("Outlook")
                }
            }
            .navigationTitle("Hurricanes")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Picker", selection: $currentTab) {
                            Text("Central Pacific").tag(Tab.centralPacific)
                            Text("Eastern Pacific").tag(Tab.easternPacific)
                            Text("Atlantic").tag(Tab.atlantic)
                        }
                        .onChange(of: currentTab) {
                            switch currentTab {
                            case .centralPacific:
                                outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_cpac_"
                                queryParameters = "?basin=cpac"
                            case .easternPacific:
                                outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_pac_"
                                queryParameters = "?basin=epac"
                            case .atlantic:
                                outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_atl_"
                                queryParameters = String() // No parameters
                            }
                            hurricanesHelper.getProductText(resource: "https://www.nhc.noaa.gov/gtwo.php" + queryParameters) { text in
                                Task {
                                    outlookText = text
                                }
                            }
                        }
                    } label: {
                        Text(currentTab.rawValue)
                    }
                }
            }
        }
        .task {
            // Outlook Text
            hurricanesHelper.getProductText(resource: "https://www.nhc.noaa.gov/gtwo.php" + queryParameters) { text in
                Task {
                    outlookText = text
                }
            }
        }
    }
}

#Preview {
    //HurricanesView()
    ContentView()
}
