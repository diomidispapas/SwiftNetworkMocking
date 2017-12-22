//
//  ViewState.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

/// https://github.com/peteog/WaitsForConnectivity
enum ViewState<T> {
    case loading
    case loaded(T)
    case error(Error)
}
