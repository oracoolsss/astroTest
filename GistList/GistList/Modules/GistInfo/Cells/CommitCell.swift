//
//  CommitCell.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

class CommitCell: UICollectionViewCell {
    
    private let commitMessageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let commitAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let commitDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(commitMessageLabel)
        contentView.addSubview(commitAuthorLabel)
        contentView.addSubview(commitDateLabel)
        
        commitMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        commitAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        commitDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            commitMessageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            commitMessageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            commitMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            commitAuthorLabel.topAnchor.constraint(equalTo: commitMessageLabel.bottomAnchor, constant: 8),
            commitAuthorLabel.leadingAnchor.constraint(equalTo: commitMessageLabel.leadingAnchor),
            
            commitDateLabel.topAnchor.constraint(equalTo: commitMessageLabel.bottomAnchor, constant: 8),
            commitDateLabel.trailingAnchor.constraint(equalTo: commitMessageLabel.trailingAnchor),
            commitDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with viewModel: Commit) {
        commitMessageLabel.text = viewModel.changeStatus?.toString()
        commitAuthorLabel.text = "Author: \(viewModel.user?.login ?? "anon")"
        commitDateLabel.text = viewModel.committedAt
    }
}

extension ChangeStatus {
    func toString() -> String? {
        guard let additions = self.additions, let deletions = self.deletions, let total = self.total else {
            return nil
        }
        return "+\(additions), -\(deletions), total: \(total)"
    }
}
