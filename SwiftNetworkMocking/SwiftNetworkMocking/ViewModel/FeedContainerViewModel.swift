//
//  FeedContainerViewModel.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

protocol FeedContainerViewModelDelegate: class {
    func feedContainerViewModel(_ : FeedContainerViewModel, didChange state: ViewState<RSSFeed>)
}

final class FeedContainerViewModel {
    
    weak var delegate: FeedContainerViewModelDelegate?
    
    var state: ViewState<RSSFeed> = .loading {
        didSet {
            handle(state: state)
        }
    }
    
    private let client: AnyRemoteRequestExecutable<RSSFeed>
    
    // MARK: Initialization
    
    init(client: AnyRemoteRequestExecutable<RSSFeed>) {
        self.client = client
    }
    
    // MARK: Public
    
    func fetchData() {
        state = .loading
        client.execute { [weak self] (feed, error) in
            guard let `self` = self else { return }
            if let feed = feed {
                self.state = .loaded(feed)
            }
            
            if let error = error {
                self.state = .error(error)
            }
        }
    }
    
    // MARK: Private
    
    private func handle(state: ViewState<RSSFeed>) {
        delegate?.feedContainerViewModel(self, didChange: state)
    }
}
