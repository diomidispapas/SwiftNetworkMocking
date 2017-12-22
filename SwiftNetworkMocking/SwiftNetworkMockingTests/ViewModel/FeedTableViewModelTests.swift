//
//  FeedTableViewModelTests.swift
//  SwiftNetworkMockingTests
//
//  Created by Diomidis Papas on 22/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import XCTest
@testable import SwiftNetworkMocking

final class FeedTableViewModelTests: XCTestCase {
    
    private let feedData: Data = FileReader().read(from: "rss_feed_response.json")!
    private let decoder = JSONDecoder()
    private lazy var feed: Feed = {
        let rssFeed = try! decoder.decode(RSSFeed.self, from: feedData)
        return rssFeed.feed
    }()

    func testFeedTableViewModel_validInitialization() {
        let viewModel = FeedTableViewModel(feed: feed)
        XCTAssertNotNil(viewModel)
    }
    
    func testFeedTableViewModel_title() {
        let viewModel = FeedTableViewModel(feed: feed)
        XCTAssertEqual(viewModel.title, "Top Audio Podcasts")
    }
    
    func testFeedTableViewModel_dataSource_forValidIndexPath() {
        let viewModel = FeedTableViewModel(feed: feed)
        let indexPath = IndexPath(row: 0, section: 0)
        let dataSource = viewModel.dataSource(for: indexPath)
        let expectedDataSource = PodcastTableViewCellDataSource(title: "My Dad Wrote A Porno", subtitle: "My Dad Wrote A Porno")
        XCTAssertEqual(dataSource, expectedDataSource)
    }
}

extension PodcastTableViewCellDataSource: Equatable {
    public static func ==(lhs: PodcastTableViewCellDataSource, rhs: PodcastTableViewCellDataSource) -> Bool {
        return lhs.title == rhs.title && lhs.subtitle == rhs.subtitle
    }
}

