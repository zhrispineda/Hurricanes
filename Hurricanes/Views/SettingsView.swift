//
//  SettingsView.swift
//  Hurricanes
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Link("National Hurricane Center", destination: URL(string: "https://www.nhc.noaa.gov")!)
                    Link("National Oceanic and Atmospheric Administration", destination: URL(string: "https://www.noaa.gov")!)
                } header: {
                    Text("Acknowledgements")
                } footer: {
                    Text("Data is from the National Hurricane Center and the National Oceanic and Atmospheric Administration.")
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
