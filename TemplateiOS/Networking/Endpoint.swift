//
//  Endpoint.swift
//  Template
//
//  Created by Rameez Khan on 17/10/21.
//

import Foundation

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example itunes.apple.com
    var baseURL: String { get }
    
    // /search/
    var path: String { get }
    
    // search?term=taylor+swift
    var queryItems: [URLQueryItem] { get }
    
    var method: String { get }
    
    func generateURLRequest() -> URLRequest?
}

extension Endpoint {
    func generateURLRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = baseURL
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method
        return request
    }
}
