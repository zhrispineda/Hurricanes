//
//  HurricanesTests.swift
//  HurricanesTests
//

import Testing
@testable import Hurricanes

struct HurricanesTests {
    // MARK: Test image endpoints from NOAA
    @Test(arguments: [
        "https://www.nhc.noaa.gov/xgtwo/two_atl_7d0.png", // 7-day Atlantic Outlook
        "https://www.nhc.noaa.gov/xgtwo/two_atl_2d0.png", // 2-day Atlantic Outlook
        "https://www.nhc.noaa.gov/xgtwo/two_pac_2d0.png", // 2-day Pacific Outlook
        "https://www.nhc.noaa.gov/xgtwo/two_cpac_2d0.png", // 2-day Central Pacific Outlook
    ])
    func imageEndpointsExist(endpointURL: String) async throws {
        let hurricanesHelper = HurricanesHelper()
        let img = await hurricanesHelper.getImage(from: endpointURL)
        #expect(img != nil)
    }
}
