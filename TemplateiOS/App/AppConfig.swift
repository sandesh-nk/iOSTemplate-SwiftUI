//
//  AppConfig.swift
//  TemplateiOS
//
//  Created by Sandesh Naik on 30/09/24.
//

import Foundation

enum AppConfig {
    
    enum Keys {
        static let baseUrlKey = "BASE_URL"
        static let apiKey = "GECKO_API_KEY"
    }
    
    /// Getting plist values here
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist file not found")
        }
        return dict
    }()
    
    /// Fetch environment specific _BASE_URL_ for application
    static let baseUrl: String = {
        guard let urlString: String = AppConfig.infoDictionary[Keys.baseUrlKey] as? String else {
            fatalError("BASE_URL key not set in plist")
        }
        
        return urlString
    }()
    
    static let apiKey: String = {
        guard let urlString: String = AppConfig.infoDictionary[Keys.apiKey] as? String else {
            fatalError("API_KEY key not set in plist")
        }
        
        return urlString
    }()
}
