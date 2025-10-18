//
//  HurricanesHelper.swift
//  Hurricanes
//
//  Created by Chris on 12/7/24.
//

import SwiftUI
import os
import SwiftSoup

class HurricanesHelper {
    let logger = Logger(subsystem: "Hurricanes", category: "ContentView")
    
    /// Returns data within the textproduct class based on the NHC website
    func getProductText(resource: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: resource) else {
            logger.error("URL is invalid.")
            completion("URL is invalid.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                self.logger.error("Error fetching URL: \(error.localizedDescription)")
                completion("Could not load data.")
                return
            }
            
            guard let data = data, let html = String(data: data, encoding: .utf8) else {
                completion("Could not load data.")
                return
            }
            
            do {
                let els: Elements = try SwiftSoup.parse(html).select(".textproduct")
                completion(try els.text())
            } catch let error as NSError {
                self.logger.error("SwiftSoup error: \(error.localizedDescription)")
                completion("Could not parse data.")
            }
        }
        .resume()
    }
    
    /// Returns a UIImage from a URL
    func getImage(from urlString: String) async -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return UIImage(data: data)
        } catch {
            logger.error("Could not get image: \(error.localizedDescription)")
            return nil
        }
    }
}
