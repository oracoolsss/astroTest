//
//  GistDetailCell.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

class FilesCell: UICollectionViewCell {
    
    private let filesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.backgroundColor = .systemGroupedBackground
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(filesStackView)
        filesStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filesStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            filesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            filesStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            filesStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            filesStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(with loadedFiles: [GistInfoFile?]) {
        filesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        var files: [GistInfoFile] = []
        for loadedFile in loadedFiles {
            if let file = loadedFile {
                files.append(file)
            }
        }
        files.forEach { file in
            let fileLabel = UILabel()
            fileLabel.font = UIFont.systemFont(ofSize: 14)
            fileLabel.text = "File: \(file.filename ?? "Unknown file"):\nFile content:\n\(file.content ?? "No content to show")"
            fileLabel.numberOfLines = 7 // 5 lines of file + labels and filename
            fileLabel.backgroundColor = .systemBackground
            filesStackView.addArrangedSubview(fileLabel)
        }
    }
}
