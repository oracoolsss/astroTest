//
//  GistDetailViewController.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

protocol GistInfoViewProtocol: AnyObject {
    func showGistInfo(with gist: GistInfo)
}

class GistInfoViewController: UIViewController {
    
    var presenter: GistInfoPresenterProtocol!
    var gist: Gist!
    
    private var collectionView: UICollectionView!
    let refreshControl = UIRefreshControl()
    
    private var gistDetail: GistInfo?
    var files: [GistInfoFile?] = []
    private var commits: [Commit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.viewDidLoad(gist.id)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = view.bounds.width
            let itemHeight = layout.itemSize.height
            layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            layout.invalidateLayout()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.collectionView.refreshControl?.beginRefreshing()
        if let gistDetail = gistDetail {
            showGistInfo(with: gistDetail)
        }
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: layout.itemSize.width, height: layout.itemSize.height)
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GistCollectionViewCell.self, forCellWithReuseIdentifier: GistCollectionViewCell.identifier)
        collectionView.register(FilesCell.self, forCellWithReuseIdentifier: "FilesCell")
        collectionView.register(CommitCell.self, forCellWithReuseIdentifier: "CommitCell")
        
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading gist...")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
}

extension GistInfoViewController: GistInfoViewProtocol {
    func showGistInfo(with gist: GistInfo) {
        if let loadedFiles = gist.files {
            self.files = loadedFiles.map { $0.value }
        }
        if let loadedCommits = gist.history {
            self.commits = loadedCommits
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension GistInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section != 2 ? 1 : commits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GistCollectionViewCell.identifier, for: indexPath) as! GistCollectionViewCell
            cell.configure(with: gist)
            return cell
        }
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilesCell", for: indexPath) as! FilesCell
            cell.configure(with: files)
            cell.layoutIfNeeded()
            return cell
        }
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommitCell", for: indexPath) as! CommitCell
            cell.configure(with: commits[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1, let file = files[indexPath.row] {
            presenter.didSelectFile(from: file)
        }
    }
}
