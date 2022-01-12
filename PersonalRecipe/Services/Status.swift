//
//  Status.swift
//  Aswani
//
//  Created by Aswani on 11/29/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

enum Status: Int {
    case success = 200
    case multipleChoices = 300
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case requestTimeout = 408
    case internalServerError = 500
    case notImplemented = 501
    case badGateway = 502
    case serviceUnavailabe = 503
    case gatewayTimeout = 504
}
