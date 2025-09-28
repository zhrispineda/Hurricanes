//
//  SatellitesView.swift
//  Hurricanes
//

import SwiftUI

struct SatellitesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    PFAnimatedImage("https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/GOES16-TAW-GEOCOLOR-900x540.gif")
                        .aspectRatio(900/540, contentMode: .fit)
                } header: {
                    Text("Atlantic GEOCOLOR")
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
