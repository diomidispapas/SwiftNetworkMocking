//
//  RemoteRequestExecutable.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

protocol RemoteRequestExecutable {
    associatedtype T
    var resource: Resource<T> { get }
    func execute(with completionHandler: @escaping (T?, Error?) -> Void)
}
