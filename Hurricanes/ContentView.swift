//
//  ContentView.swift
//  Hurricanes
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Tabs = .hurricanes
    
    // Variables
    enum Tabs {
        case hurricanes, satellites, information, settings
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            Tab("Hurricanes", systemImage: "hurricane", value: .hurricanes) {
                HurricanesView()
            }
            Tab("Satellites", systemImage: "arrow.triangle.2.circlepath.icloud.fill", value: .satellites) {
                SatellitesView()
            }
            Tab("Information", systemImage: "text.document.fill", value: .information) {
                EmptyView()
            }
            Tab("Settings", systemImage: "gear", value: .settings) {
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
