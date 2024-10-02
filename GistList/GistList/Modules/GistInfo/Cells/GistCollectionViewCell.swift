//
//  GistCollectionViewCell.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

class GistCollectionViewCell: UICollectionViewCell {
    static let identifier = "GistCollectionViewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with gist: Gist) {
        if let description = gist.description, !description.isEmpty {
            titleLabel.text = description
        } else {
            titleLabel.text = "Public gist \(gist.id)"
        }
        if let owner = gist.owner {
            authorLabel.text = owner.login
            ImageCacheManager.shared.loadImage(from: owner.avatarURL) { [weak self] image in
                guard let self = self else { return }
                self.setupImage(image)
            }
        } else {
            authorLabel.text = "Unknown user"
            setupImage()
        }
    }
    
    private func setupImage(_ image: UIImage? = nil) {
        if let image = image {
            self.avatarImageView.image = image
        } else {
            self.avatarImageView.image = UIImage(systemName: "questionmark.square.fill")
        }
    }
}
