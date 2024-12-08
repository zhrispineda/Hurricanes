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
    @State private var queryParameters = String()
    @State private var outlookText = "Loading..."
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
                .sectionHeaderStyle()
                
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
                .sectionHeaderStyle()
                
                // Outlook Text
                Section {
                    DisclosureGroup("\(currentTab.rawValue) Tropical Weather Outlook") {
                        Text(outlookText)
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                } header: {
                    Text("Outlook")
                        .sectionHeaderStyle()
                }
            }
            .listStyle(.inset)
            .navigationTitle("Hurricanes")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Picker("Picker", selection: $currentTab) {
                        Text("Central Pacific").tag(Tab.centralPacific)
                        Text("Eastern Pacific").tag(Tab.easternPacific)
                        Text("Atlantic").tag(Tab.atlantic)
                    }
                    .pickerStyle(SegmentedPickerStyle())
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
                            DispatchQueue.main.async {
                                outlookText = text
                            }
                        }
                    }
                }
            }
        }
        .task {
            // Outlook Text
            hurricanesHelper.getProductText(resource: "https://www.nhc.noaa.gov/gtwo.php" + queryParameters) { text in
                DispatchQueue.main.async {
                    outlookText = text
                }
            }
        }
    }
}

#Preview {
    HurricanesView()
}
