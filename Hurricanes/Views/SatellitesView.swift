//
//  SatellitesView.swift
//  Hurricanes
//

import SwiftUI

struct SatellitesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Tropical Atlantic GEOCOLOR") {
                    ISAnimatedImageViewLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/GOES16-TAW-GEOCOLOR-900x540.gif")
                        .aspectRatio(900/540, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                .sectionHeaderStyle()
                
                Section("Atlantic Coast GEOCOLOR") {
                    ISAnimatedImageViewLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR/eus/GEOCOLOR/GOES19-EUS-GEOCOLOR-1000x1000.gif")
                        .aspectRatio(1000/1000, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                .sectionHeaderStyle()
                
                Section("Pacific GEOCOLOR") {
                    ISAnimatedImageViewLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES18/ABI/SECTOR/tpw/GEOCOLOR/GOES18-TPW-GEOCOLOR-900x540.gif")
                        .aspectRatio(900/540, contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                .sectionHeaderStyle()
            }
            .navigationTitle("Satellites")
        }
    }
}

#Preview {
    SatellitesView()
}
