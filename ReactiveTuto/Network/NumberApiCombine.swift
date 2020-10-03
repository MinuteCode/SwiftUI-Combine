//
//  NumberApiCombine.swift
//  ReactiveTuto
//
//  Created by Benjamin Ameur on 03/10/2020.
//  Copyright © 2020 Benjamin Ameur. All rights reserved.
//

import Foundation
import Combine

enum NumberApiCombine {
    
    case randomNumber(min: Int, max: Int, count: Int?)
    
    private var baseUrl: URL {
        return URL(string: "http://www.randomnumberapi.com/api/v1.0")!
    }
    
    private var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    var path: URL {
        switch self {
        case .randomNumber(let min, let max, let count):
            ///TODO : Refactor this !
            ///See why `URL(string: "/random?min=\(min)&max=\(max)&count=\(count ?? 1)", relativeTo: baseUrl)!` strips "/api/v1.0" from the url
            let url = URL(string: "http://www.randomnumberapi.com/api/v1.0/random?min=\(min)&max=\(max)&count=\(count ?? 1)")!
            return url
        }
    }
    
    func publish() -> AnyPublisher<[Int], Error> {
        return session.dataTaskPublisher(for: URLRequest(url: path))
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                        return Data()
                }
                    
                return data
            }
            .decode(type: [Int].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
