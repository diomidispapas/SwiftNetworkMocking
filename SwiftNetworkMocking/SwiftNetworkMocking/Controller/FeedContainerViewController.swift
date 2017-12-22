//
//  FeedContainerViewController.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import UIKit

final class FeedContainerViewController: UIViewController {
    
    private let viewModel: FeedContainerViewModel
    
    private var activeViewController: UIViewController? {
        didSet {
            remove(viewController: oldValue)
            activate(viewController: activeViewController)
        }
    }
    
    // MARK: Initialization
    
    init(viewModel: FeedContainerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    
    private func setupDefaults() {
        view.backgroundColor = .white
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    private func handle(state: ViewState<RSSFeed>) {
        assert(Thread.isMainThread)
        switch state {
        case .loading:
            activeViewController = LoadingViewController(nibName: nil, bundle: nil)
            
        case let .loaded(feed):
            let feedViewModel = FeedTableViewModel(feed: feed.feed)
            let feedTableViewController = FeedTableViewController(viewModel: feedViewModel)
            let feedNavigationControlle = UINavigationController.init(rootViewController: feedTableViewController)
            activeViewController = feedNavigationControlle
            
        case .error:
            fatalError("An error occured while loading the feed, we should handle the error in a real application by presenting an appropriate error to the user")
        }
    }
    
    private func activate(viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        addChildViewController(viewController)
        viewController.view.frame = view.bounds
        view.addSubview(viewController.view)
        viewController.didMove(toParentViewController: self)
        title = viewController.title
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func remove(viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}

extension FeedContainerViewController: FeedContainerViewModelDelegate {
    func feedContainerViewModel(_: FeedContainerViewModel, didChange state: ViewState<RSSFeed>) {
        handle(state: state)
    }
}
