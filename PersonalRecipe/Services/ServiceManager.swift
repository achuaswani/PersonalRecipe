//
//  ServiceManager.swift
//  Aswani
//
//  Created by Aswani on 11/26/20.
//  Copyright © 2020 Aswani. All rights reserved.
//

import Foundation

protocol ServiceManagerType {
    func getRequest<T: Decodable>(path: String, completionHandler: @escaping(Result<T, APIError>) -> Void)
    func postRequest<T: Decodable>(path: String, body: Recipe, completionHandler: @escaping(Result<T, APIError>) -> Void)
}

class ServiceManager: ServiceManagerType {
    let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func getRequest<T>(path: String, completionHandler: @escaping (Result<T, APIError>) -> Void) where T : Decodable {
        guard let url = Endpoint.categories(path: path).url else {
            return
        }
        serviceCall(URLRequest(url: url), completionHandler: completionHandler)
    }
    
    func postRequest<T: Decodable>(path: String, body: Recipe, completionHandler: @escaping(Result<T, APIError>) -> Void) {
        guard let url = Endpoint.categories(path: path).url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.recipeData()
        
        serviceCall(request, completionHandler: completionHandler)

    }
    
    private func serviceCall<T: Decodable>(_ request: URLRequest,  completionHandler:  @escaping(Result<T, APIError>) -> Void) {
        
        urlSession.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            // For testing Activity indicator
            sleep(5)
            
            if let error = error {
                if error._code == -1009 {
                    completionHandler(.failure(.offline(message: error.localizedDescription)))
                } else {
                    completionHandler(Result.failure(.sessionError(cause: error)))
                }
                return
            }
            guard let response = response as? HTTPURLResponse, let data = data else {
                completionHandler(Result.failure(.missingDataError))
                return
            }
            guard (200..<300).contains(response.statusCode) else {
                let responseBody = String(data: data, encoding: .utf8)
                switch Status(rawValue: response.statusCode) {
                case .requestTimeout:
                    completionHandler(.failure(.timeoutError))
                case .internalServerError:
                    completionHandler(.failure(.internalServerError))
                case .notFound:
                    completionHandler(.failure(.notFound))
                default:
                    completionHandler(.failure(.apiError(status: response.statusCode, message: responseBody)))
                }
                
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(result))
            } catch {
                completionHandler(.failure(.parsingError))
            }
            
            return
        }).resume()
    }
}
