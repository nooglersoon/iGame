//
//  HTTPMethod.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation

enum HTTPMethod: String {
    
    case delete
    case get
    case patch
    case post
    case put
    
    var methodName: String { rawValue.uppercased() }
    
}
