//
//  AppConstants.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

struct AppConstants {
    #if DEBUG
    static let BASEURL = "localhost"
    static let PORT = 8080
    static let TIMEOUTINTERVAL = 1.0
    #else
    static let BASEURL = "127.0.0.1"
    static let PORT = 8080
    static let TIMEOUTINTERVAL = 5.0
    #endif

    static let RECIPES = "/api/recipes"
}
