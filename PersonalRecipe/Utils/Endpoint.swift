//
//  Endpoints.swift
//  Aswani
//
//  Created by Aswani on 11/29/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = AppConstants.BASEURL
        components.port = AppConstants.PORT
        components.path = path
        components.queryItems = queryItems

        guard let url = components.url else {
            return nil
        }
        return url
    }
}

extension Endpoint {
    static func categories(path: String) -> Self {
        Endpoint(path: path)
    }
    
    static func fetch(_ path: String, _ start: Int, _ limit: Int) -> Self {
        Endpoint(
            path: path,
            queryItems: [URLQueryItem(
                name: "start",
                value: String(start)
            ), URLQueryItem(
                name: "limit",
                value: String(limit)
            )]
        )
    }
}
