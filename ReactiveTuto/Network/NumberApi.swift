//
//  NumberApi.swift
//  ReactiveTuto
//
//  Created by Benjamin Ameur on 03/10/2020.
//  Copyright © 2020 Benjamin Ameur. All rights reserved.
//

import Foundation
import Moya

enum NumberAPI: TargetType {
    
    case randomNumber(min: Int, max: Int, count: Int?)
    
    var baseURL: URL {
        return URL(string: "http://www.randomnumberapi.com/api/v1.0")!
    }
    
    var path: String {
        switch self {
        case .randomNumber:
            return "/random"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .randomNumber:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .randomNumber(_, _, let count):
            return Array(1...count!)
                .reduce("") { (rslt, number) -> String in
                    return rslt + "\(number)"
                }.data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .randomNumber(let min, let max, let count):
            var parameters = ["min": min, "max": max]
            if count != nil {
                parameters["count"] = count
            }
            return .requestParameters(
                parameters: parameters,
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
