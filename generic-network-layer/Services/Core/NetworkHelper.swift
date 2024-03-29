//
//  NetworkHelper.swift
//  generic-network-layer
//
//  Created by Mursel Elibol on 23.11.2023.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Encodable? { get }
    
    func request() -> URLRequest
}

extension Endpoint {
    var baseURL: String {
        "https://jsonplaceholder.typicode.com/"
    }
    
    var header: [String : String]? {
        ["Content-Type": "application/json", "charset": "UTF-8"]
    }

    
    func request() -> URLRequest {
        guard var components = URLComponents(string: baseURL) else { fatalError("Base URL Error") }
        components.path += path
        components.queryItems = queryItems
    
        guard let url = components.url else { fatalError("URL Error From Component") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        
        if let body = self.body {
            do {
                let data = try JSONEncoder().encode(body)
                request.httpBody = data
            } catch {
                print(error)
            }
        }
        
        if let header = header {
            header.forEach { value, key in
                request.setValue(key, forHTTPHeaderField: value)
            }
        }
        
        return request
    }
}
