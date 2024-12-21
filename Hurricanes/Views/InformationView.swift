//
//  InformationView.swift
//  Hurricanes
//

import SwiftUI
import AVKit

struct InformationView: View {
    var body: some View {
        NavigationStack {
            List {
                // What is a Hurricane? Section
                Section {
                    VideoPlayer(player: AVPlayer(url: URL(string: "https://cdn.oceanservice.noaa.gov/oceanserviceprod/facts/hurricanes-of.mp4")!))
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    Text("A hurricane is a type of storm called a tropical cyclone, which forms over tropical or subtropical waters.")
                        .textSelection(.enabled)
                } header: {
                    Text("What is a Hurricane?")
                } footer: {
                    Text("[Source: NOAA](https://oceanservice.noaa.gov/facts/hurricane.html)")
                }
                
                // Saffir-Simpson Hurricane Wind Scale Section
                Section {
                    VideoPlayer(player: AVPlayer(url: URL(string: "https://www.nhc.noaa.gov/video/SSHWS_animaton.mp4")!))
                        .aspectRatio(CGSize(width: 16, height: 9), contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding()
                    Text("The Saffir-Simpson Hurricane Wind Scale is a 1 to 5 rating based only on a hurricane's maximum sustained wind speed. **This scale does not take into account other potentially deadly hazards such as storm surge, rainfall flooding, and tornadoes.**")
                        .textSelection(.enabled)
                    Text("The Saffir-Simpson Hurricane Wind Scale estimates potential property damage. While all hurricanes produce life-threatening winds, hurricanes rated Category 3 and higher are known as major hurricanes*. Major hurricanes can cause devastating to catastrophic wind damage and significant loss of life simply due to the strength of their winds. Hurricanes of all categories can produce deadly storm surge, rain-induced floods, and tornadoes. These hazards require people to take protective action, including evacuating from areas vulnerable to storm surge.")
                    Text("*In the western North Pacific, the term \"super typhoon\" is used for tropical cyclones with sustained winds exceeding 150 mph.")
                    DisclosureGroup("**Category 1** (74-95 mph)") {
                        Text("**Very dangerous winds will produce some damage:** Well-constructed frame homes could have damage to roof, shingles, vinyl siding and gutters. Large branches of trees will snap and shallowly rooted trees may be toppled. Extensive damage to power lines and poles likely will result in power outages that could last a few to several days.")
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                    DisclosureGroup("**Category 2** (96-110 mph)") {
                        Text("**Extremely dangerous winds will cause extensive damage:** Well-constructed frame homes could sustain major roof and siding damage. Many shallowly rooted trees will be snapped or uprooted and block numerous roads. Near-total power loss is expected with outages that could last from several days to weeks.")
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                    DisclosureGroup("**Category 3** (111-129 mph)") {
                        Text("**Devastating damage will occur:** Well-built framed homes may incur major damage or removal of roof decking and gable ends. Many trees will be snapped or uprooted, blocking numerous roads. Electricity and water will be unavailable for several days to weeks after the storm passes.")
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                    DisclosureGroup("**Category 4** (130-156 mph)") {
                        Text("**Catastrophic damage will occur:** Well-built framed homes can sustain severe damage with loss of most of the roof structure and/or some exterior walls. Most trees will be snapped or uprooted and power poles downed. Fallen trees and power poles will isolate residential areas. Power outages will last weeks to possibly months. Most of the area will be uninhabitable for weeks or months.")
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                    DisclosureGroup("**Category 5** (157 mph or higher)") {
                        Text("**Catastrophic damage will occur:** A high percentage of framed homes will be destroyed, with total roof failure and wall collapse. Fallen trees and power poles will isolate residential areas. Power outages will last for weeks to possibly months. Most of the area will be uninhabitable for weeks or months.")
                            .font(.footnote)
                            .textSelection(.enabled)
                    }
                } header: {
                    Text("Saffir-Simpson Hurricane Wind Scale")
                } footer: {
                    Text("[Source: NOAA](https://www.nhc.noaa.gov/aboutsshws.php)")
                }
            }
            .navigationTitle("Information")
        }
    }
}

#Preview {
    InformationView()
}
