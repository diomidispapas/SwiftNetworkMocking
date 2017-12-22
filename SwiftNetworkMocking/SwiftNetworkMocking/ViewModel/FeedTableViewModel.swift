//
//  FeedTableViewModel.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import Foundation

struct FeedTableViewModel {
    
    let feed: Feed
    
    var title: String {
        return feed.title
    }
    
    var numberOfRows: Int {
        return feed.podcasts.count
    }
    
    func dataSource(for indexPath: IndexPath) -> PodcastTableViewCellDataSource {
        assert(feed.podcasts.count >= indexPath.row)
        let podcast = feed.podcasts[indexPath.row]
        return PodcastTableViewCellDataSource(title: podcast.name, subtitle: podcast.artistName)
    }
}
