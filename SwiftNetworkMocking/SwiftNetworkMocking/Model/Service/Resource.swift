//
//  Resource.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

/// https://github.com/objcio/S01E01-networking
struct Resource<A> {
    let urlRequest: URLRequest
    let parse: (Data) -> A?
}

extension Resource where A: Decodable  {
    init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        self.parse = { data in
            let decoder = JSONDecoder()
            return try! decoder.decode(A.self, from: data)
        }
    }
}

