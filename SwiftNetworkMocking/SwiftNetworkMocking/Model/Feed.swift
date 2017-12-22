//
//  Feed.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

/// https://useyourloaf.com/blog/swift-codable-with-custom-dates/
struct RSSFeed: Codable {
    struct Feed: Codable {
        struct Podcast: Codable {
            let artistName: String
            let name: String
            let releaseDate: Date
            let url: URL
            
            private enum CodingKeys: String, CodingKey {
                case artistName
                case name
                case releaseDate
                case url
            }
        }
        
        let title: String
        let country: String
        let updated: Date
        let podcasts: [Podcast]
        
        private enum CodingKeys: String, CodingKey {
            case title
            case country
            case updated
            case podcasts = "results"
        }
    }
    let feed: Feed
}

typealias Feed = RSSFeed.Feed
typealias Podcast = Feed.Podcast

extension Feed {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        country = try container.decode(String.self, forKey: .country)
        podcasts = try container.decode([Podcast].self, forKey: .podcasts)
        
        let dateString = try container.decode(String.self, forKey: .updated)
        let formatter = DateFormatter.iso8601Full
        if let date = formatter.date(from: dateString) {
            updated = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .updated,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}

extension Podcast {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        artistName = try container.decode(String.self, forKey: .artistName)
        url = try container.decode(URL.self, forKey: .url)
        
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: dateString) {
            releaseDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .releaseDate,
                                                   in: container,
                                                   debugDescription: "Date string does not match format expected by formatter.")
        }
    }
}
