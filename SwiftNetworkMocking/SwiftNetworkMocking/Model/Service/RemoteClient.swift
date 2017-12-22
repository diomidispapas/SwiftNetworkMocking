//
//  RemoteClient.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

struct RemoteClient<T>: RemoteRequestExecutable {
    
    // MARK: RemoteRequestExecutable
    
    let resource: Resource<T>
    
    func execute(with completionHandler: @escaping (T?, Error?) -> Void) {
        let urlRequest = resource.urlRequest
        _ = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completionHandler(nil, error)
                    return
                }
                
                guard let data = data else {
                    completionHandler(nil, error)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    assertionFailure(); return
                }
                
                switch httpResponse.statusCode {
                case 200...299:                    completionHandler(self.resource.parse(data), nil)
                    
                case 403:
                    completionHandler(nil, URLError.userAuthenticationRequired as? Error)
                    
                case 404:
                    completionHandler(nil, URLError.cannotFindHost as? Error)
                    
                case 500:
                    completionHandler(nil, URLError.badServerResponse as? Error)
                    
                default: break
                }
            }
            }.resume()
    }
}


