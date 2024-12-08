//
//  ContentView.swift
//  Hurricanes
//

import SwiftUI
import SwiftSoup
import os

struct ContentView: View {
    // Variables
    @State private var currentTab: Tab = .atlantic
    @State private var outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_atl_"
    @State private var outlookText = "Loading..."
    @State private var discussionText = "Loading..."
    let logger = Logger(subsystem: "Hurricanes", category: "ContentView")
    
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
                                            if let uiImage = await getImage(from: outlookImage + "2d0.png") {
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
                                .contextMenu {
                                    Button {
                                        Task {
                                            if let uiImage = await getImage(from: outlookImage + "7d0.png") {
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
                Section("Outlook") {
                    DisclosureGroup("\(currentTab.rawValue) Tropical Weather Outlook") {
                        Text(outlookText)
                            .font(.footnote)
                    }
                }
                
                // Discussion Text
                Section("Discussion") {
                    DisclosureGroup("\(currentTab.rawValue) Tropical Weather Discussion") {
                        Text(discussionText)
                            .font(.footnote)
                    }
                }
            }
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
                            outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_pac_"
                        case .easternPacific:
                            outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_cpac_"
                        case .atlantic:
                            outlookImage = "https://www.nhc.noaa.gov/xgtwo/two_atl_"
                        }
                    }
                }
            }
        }
        .task {
            // Outlook Text
            getProductText(resource: "https://www.nhc.noaa.gov/gtwo.php") { text in
                DispatchQueue.main.async {
                    outlookText = text
                }
            }
            
            // Discussion Text
            getProductText(resource: "https://www.nhc.noaa.gov/text/refresh/MIATWDAT+shtml/") { text in
                DispatchQueue.main.async {
                    discussionText = text
                }
            }
        }
    }
    
    // MARK: Functions
    // Returns data within the textproduct class based on the NHC website
    private func getProductText(resource: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: resource) else {
            completion("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                logger.error("Error fetching URL: \(error.localizedDescription)")
                completion("Could not load data.")
                return
            }
            
            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion("Could not load data.")
                return
            }
            
            do {
                let els: Elements = try SwiftSoup.parse(html).select(".textproduct")
                completion(try els.text())
            } catch let error as NSError {
                logger.error("SwiftSoup error: \(error.localizedDescription)")
                completion("Could not parse data.")
            }
        }
        .resume()
    }
    
    // Returns a UIImage from a URL
    func getImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            print("Could not get image: \(error)")
            return nil
        }
    }
}

#Preview {
    ContentView()
}
