//
//  APIError.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

enum APIError: Error {
    case sessionError(cause: Error)
    case apiError(status: Int, message: String? = nil)
    case parsingError
    case missingDataError
    case requestError
    case timeoutError
    case offline(message: String)
    case internalServerError
    case notFound
    
    var debugDescription: String {
        switch self {
        case .sessionError(let cause):
            return "service.response.session.error".localized() + " \(cause.localizedDescription)"
        case .apiError(let status, let message):
            return "service.response.api.error" + "\(status), \(message ?? "")"
        case .parsingError:
            return "service.response.parsing.error".localized()
        case .missingDataError:
            return "service.response.missing.data.error".localized()
        case .requestError:
            return "service.request.session.timeout".localized()
        case .timeoutError:
            return "service.request.error".localized() + "service.request.try.again".localized()
        case .offline(let message):
            return "\(message)"
        case .internalServerError:
            return "service.request.internal.server.error".localized()
        case .notFound:
            return "service.request.page.not.found".localized()
        }
    }
}

extension APIError: Equatable {
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case let (.sessionError(cause), .sessionError(cause1)):
            return cause.localizedDescription == cause1.localizedDescription
        case let (.apiError(status, message), .apiError(status1, message1)):
            return status == status1 && message == message1
        case (.parsingError, .parsingError):
            return true
        case (.missingDataError, .missingDataError):
            return true
        case (.requestError, .requestError):
            return true
        case (.timeoutError, .timeoutError):
            return true
        case (.offline(let message), .offline(let message1)):
            return message == message1
        case (.internalServerError, .internalServerError):
            return true
        case (.notFound, .notFound):
            return true
        default:
            return false
        }
    }
}
