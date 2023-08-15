//
//  RequestError.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

enum RequestError: Error {
    case noConnection
    case invalidURL
    case decode
    case noResponse
    case unauthorized(String)
    case notFound(String)
    case badRequest
    case internalServer(String)
    case unknown
    
    var customMessage: String {
        switch self {
        case .decode:
            return "Decode error"
        case .unauthorized(let error), .notFound(let error), .internalServer(let error):
            return "\(error)"
        case .invalidURL:
            return "The entered URL is invalid"
        case .noConnection:
            return "No Internet Connected"
        default:
            return "Unknown error"
        }
    }
    
    var code: Int {
        switch self {
        case .noConnection, .invalidURL, .decode, .noResponse:
            return 0
        case .unauthorized:
            return 401
        case .notFound:
            return 404
        case .badRequest:
            return 400
        case .internalServer:
            return 500
        case .unknown:
            return 0
        }
    }
    
}
