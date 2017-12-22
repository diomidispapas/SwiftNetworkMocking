//
//  Resources.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

struct Resources {
    static let feed: Resource<RSSFeed> = {
        let urlRequest = URLRequest(url: URL(string: "https://rss.itunes.apple.com/api/v1/gb/podcasts/top-podcasts/all/10/explicit.json")!)
        return Resource<RSSFeed>(urlRequest: urlRequest)
    }()
}
