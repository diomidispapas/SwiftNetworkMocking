//
//  AnyRemoteRequestExecutable.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

/// Type Erased `RemoteRequestExecutable`
class AnyRemoteRequestExecutable<T>: RemoteRequestExecutable {
    
    typealias Completion = (T?, Error?) -> Void
    
    private let executeClosure: (Completion) -> ()
    
    // MARK: Initialization
    
    init<R: RemoteRequestExecutable>(remoteRequestExecutable: R) where R.T == T {
        resource = remoteRequestExecutable.resource
        executeClosure = remoteRequestExecutable.execute as! ((T?, Error?) -> Void) -> ()
    }
    
    // MARK: RemoteRequestExecutable
    
    var resource: Resource<T>
    
    func execute(with completionHandler: @escaping Completion) {
        executeClosure(completionHandler)
    }
}

