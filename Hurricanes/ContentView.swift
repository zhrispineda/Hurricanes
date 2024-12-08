//
//  ContentView.swift
//  Hurricanes
//

import SwiftUI

struct ContentView: View {
    @State private var currentTab: Tabs = .hurricanes
    
    // Variables
    enum Tabs {
        case hurricanes, satellite
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            Tab("Hurricanes", systemImage: "hurricane", value: .hurricanes) {
                HurricanesView()
            }
            Tab("Satellite Imagery", systemImage: "hurricane", value: .satellite) {
                EmptyView()
            }
        }
    }
}

#Preview {
    ContentView()
}
