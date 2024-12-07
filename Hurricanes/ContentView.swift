//
//  ContentView.swift
//  Hurricanes
//

import SwiftUI
import SwiftSoup
import os

struct ContentView: View {
    // Variables
    let logger = Logger(subsystem: "Hurricanes", category: "ContentView")
    
    var body: some View {
        NavigationStack {
            List {
                // Atlantic Outlook Image
                AsyncImage(url: URL(string: "https://www.nhc.noaa.gov/xgtwo/two_atl_7d0.png")) { status in
                    switch status {
                    case .failure:
                        Text("Could not get Atlantic Outlook image.")
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    default:
                        ProgressView()
                    }
                }
                
                // Discussion Text
                DisclosureGroup("Atlantic Tropical Weather Outlook") {
                    Text(getProductText(resource: "https://www.nhc.noaa.gov/gtwo.php"))
                        .font(.footnote)
                }
                DisclosureGroup("Atlantic Tropical Weather Discussion") {
                    Text(getProductText(resource: "https://www.nhc.noaa.gov/text/refresh/MIATWDAT+shtml/"))
                        .font(.footnote)
                }
            }
            .navigationTitle("Hurricanes")
        }
    }
    
    // MARK: Functions
    // Returns weather discussion product text
    private func getProductText(resource: String) -> String {
        guard let url = URL(string: resource) else {
            return "Invalid URL"
        }
        
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
            let els: Elements = try SwiftSoup.parse(html).select(".textproduct")
            return try els.text()
        } catch let error as NSError {
            logger.error("\(error.localizedDescription)")
            return "Could not load discussion text."
        }
    }
}

#Preview {
    ContentView()
}
