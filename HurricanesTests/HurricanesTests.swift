//
//  HurricanesTests.swift
//  HurricanesTests
//

import Testing
@testable import Hurricanes

struct HurricanesTests {
    // MARK: - 7 day and 2 day image endpoints
    
    // 2-day Atlantic Outlook
    @Test func twoDayAtlanticOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_atl_2d0.png") {
            #expect(uiImage != nil)
        }
    }
    
    // 2-day Central Pacific Outlook
    @Test func twoDayCentralPacificOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_cpac_2d0.png") {
            #expect(uiImage != nil)
        }
    }
    
    // 2-day Eastern Pacific Outlook
    @Test func twoDayEasternPacificOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_pac_2d0.png") {
            #expect(uiImage != nil)
        }
    }
    
    // 7-day Atlantic Outlook
    @Test func sevenDayAtlanticOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_atl_7d0.png") {
            #expect(uiImage != nil)
        }
    }
    
    // 7-day Central Pacific Outlook
    @Test func sevenDayCentralPacificOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_cpac_2d0.png") {
            #expect(uiImage != nil)
        }
    }
    
    // 7-day Eastern Pacific Outlook
    @Test func sevenDayEasternPacificOutlookImage() async throws {
        let hurricanesHelper = HurricanesHelper()
        
        if let uiImage = await hurricanesHelper.getImage(from: "https://www.nhc.noaa.gov/xgtwo/two_pac_2d0.png") {
            #expect(uiImage != nil)
        }
    }
}
