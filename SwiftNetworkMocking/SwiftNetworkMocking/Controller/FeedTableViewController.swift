//
//  FeedTableViewController.swift
//  SwiftNetworkMocking
//
//  Created by Diomidis Papas on 21/12/2017.
//  Copyright © 2017 Diomidis Papas. All rights reserved.
//

import UIKit

final class FeedTableViewController: UITableViewController {
    
    private let viewModel: FeedTableViewModel
    
    // MARK: Initialization
    
    init(viewModel: FeedTableViewModel) {
        self.viewModel = viewModel
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItem()
        setupTableView()
    }
    
    // MARK: Private

    private func setupNavigationItem() {
        navigationItem.title = viewModel.title
    }
    
    private func setupTableView() {
        tableView.register(PodcastTableViewCell.self)
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = true
    }
}

// MARK: UITableViewDataSource
extension FeedTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PodcastTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let dataSource = viewModel.dataSource(for: indexPath)
        cell.configure(with: dataSource)
        return cell
    }
}
