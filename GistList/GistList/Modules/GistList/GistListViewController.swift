//
//  GistListViewController.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 01.10.2024.
//

import Foundation
import UIKit

protocol GistListViewProtocol: AnyObject {
    func showGists(_ gists: [Gist])
}

class GistListViewController: UIViewController {
    let refreshControl = UIRefreshControl()
    var presenter: GistListPresenterProtocol!
    private var gists: [Gist] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 70
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(GistTableViewCell.self, forCellReuseIdentifier: GistTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.attributedTitle = NSAttributedString(string: "Reloaded gists...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        setupUI()
        presenter.loadGists()
    }

    @objc func refresh(_ sender: AnyObject) {
        presenter.reloadGists() { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
    }

    private func setupUI() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        navigationItem.title = "Public gists"
    }
}

extension GistListViewController: GistListViewProtocol {
    func showGists(_ gists: [Gist]) {
        self.gists = gists
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension GistListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GistTableViewCell.identifier, for: indexPath) as! GistTableViewCell
        let gist = gists[indexPath.row]
        cell.configure(with: gist)
        if indexPath.row == gists.count - 1 {
            presenter.loadGists()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectGist(gists[indexPath.row])
    }
}
