//
//  FeedContainerViewModelTests.swift
//  SwiftNetworkMockingTests
//
//  Created by Diomidis Papas on 22/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import XCTest
@testable import SwiftNetworkMocking

final class FeedContainerViewModelTests: XCTestCase {
    
    private let localClient = LocalClient(resource: Resources.feed, filepath: "rss_feed_response.json")
    
    private lazy var typeErasedRemoteRequestExecutable: AnyRemoteRequestExecutable  = {
        return AnyRemoteRequestExecutable(remoteRequestExecutable: localClient)
    }()
    
    func testFeedContainerViewModel_validInitialization() {
        let viewModel = FeedContainerViewModel(client: typeErasedRemoteRequestExecutable)
        XCTAssertNotNil(viewModel)
    }
    
    func testFeedContainerViewModel_receivesDelegateCallbacks_whenStateChanges() {
        let viewModel = FeedContainerViewModel(client: typeErasedRemoteRequestExecutable)
        let mockDelegate = MockFeedContainerViewModelDelegate()
        let delegateExpecation = expectation(description: #function)
        mockDelegate.callback = { [weak delegateExpecation] state in
            delegateExpecation?.fulfill()
            delegateExpecation = nil
        }
        viewModel.delegate = mockDelegate
        viewModel.fetchData()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testFeedContainerViewModel_hasErrorStateWithError_whenServiceReturnsError() {
        let errorClient = ErrorClient(resource: Resources.feed, error: ErrorClientError.default)
        let typeErasedRemoteRequestExecutable = AnyRemoteRequestExecutable(remoteRequestExecutable: errorClient)
        let viewModel = FeedContainerViewModel(client: typeErasedRemoteRequestExecutable)

        let mockDelegate = MockFeedContainerViewModelDelegate()
        let delegateExpecation = expectation(description: #function)
        mockDelegate.callback = { [weak delegateExpecation] state in
            switch state {
            case let .error(error):
                XCTAssertNotNil(error)
                XCTAssert(true)
                delegateExpecation?.fulfill()
                delegateExpecation = nil
            case .loading:
                break
            case .loaded:
                XCTAssert(false)
            }
        }
        viewModel.delegate = mockDelegate
        viewModel.fetchData()
        waitForExpectations(timeout: 0.1, handler: nil)
    }
}

final private class MockFeedContainerViewModelDelegate: FeedContainerViewModelDelegate {
    
    var callback: ((ViewState<RSSFeed>) -> Void)?
    
    func feedContainerViewModel(_ : FeedContainerViewModel, didChange state: ViewState<RSSFeed>) {
        callback?(state)
    }
}


