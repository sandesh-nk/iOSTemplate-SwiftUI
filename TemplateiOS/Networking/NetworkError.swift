//
//  NetworkError.swift
//  TemplateiOS
//
//  Created by Wednesday on 21/08/24.
//

import Foundation

enum NetworkError: Error {
    case inValidEndPoint //Failed to turn EndPoint into valid url request
    case failed(statusCode: Int)
    case invalidResponse
    case parsingError
    case unknownError
}
