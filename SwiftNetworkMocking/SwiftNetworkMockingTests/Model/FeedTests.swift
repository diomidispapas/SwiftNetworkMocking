//
//  FeedTests.swift
//  SwiftNetworkMockingTests
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import XCTest
@testable import SwiftNetworkMocking

final class FeedTests: XCTestCase {
    
    private let feedData: Data = FileReader().read(from: "rss_feed_response.json")!
    private let decoder = JSONDecoder()

    func testFeedDecoding_withValidInputData_isNotNil() {
        let feed = try? decoder.decode(RSSFeed.self, from: feedData)
        XCTAssertNotNil(feed)
    }
    
    func testFeedDecoding_withValidInputData_hasValidTitle() {
        let feed = try? decoder.decode(RSSFeed.self, from: feedData)
        XCTAssertEqual(feed?.feed.title, "Top Audio Podcasts")
    }
    
    func testFeedDecoding_withValidInputData_hasNonNilPodcasts() {
        let feed = try? decoder.decode(RSSFeed.self, from: feedData)
        XCTAssertNotNil(feed?.feed.podcasts)
    }
    
    func testFeedDecoding_withValidInputData_hasCorrectNumberOfPodcasts() {
        let feed = try? decoder.decode(RSSFeed.self, from: feedData)
        XCTAssertEqual(feed?.feed.podcasts.count, 3)
    }

}
