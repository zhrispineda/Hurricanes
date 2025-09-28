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
                    PFAnimatedImageLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES16/ABI/SECTOR/taw/GEOCOLOR/GOES16-TAW-GEOCOLOR-900x540.gif")
                        .aspectRatio(900/540, contentMode: .fit)
                }
                .sectionHeaderStyle()
                
                Section("Atlantic Coast GEOCOLOR") {
                    PFAnimatedImageLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES19/ABI/SECTOR/eus/GEOCOLOR/20252711301-20252711711-GOES19-ABI-EUS-GEOCOLOR-1000x1000.gif")
                        .aspectRatio(1000/1000, contentMode: .fit)
                }
                .sectionHeaderStyle()
                
                Section("Pacific GEOCOLOR") {
                    PFAnimatedImageLoader(link: "https://cdn.star.nesdis.noaa.gov/GOES18/ABI/SECTOR/tpw/GEOCOLOR/20252710710-20252711700-GOES18-ABI-TPW-GEOCOLOR-900x540.gif")
                        .aspectRatio(900/540, contentMode: .fit)
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
