//
//  GistDetailRouter.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

protocol GistInfoRouterProtocol: AnyObject {
    func presentFileContent(from gist: GistInfoFile)
}

class GistInfoRouter: GistInfoRouterProtocol {
    weak var viewController: UIViewController?

    static func createModule(gist: Gist) -> UIViewController {
        let view = GistInfoViewController()
        let interactor = GistInfoInteractor(gist: gist)
        let presenter = GistInfoPresenter()
        let router = GistInfoRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        view.gist = gist

        return view
    }
    
    func presentFileContent(from file: GistInfoFile) {
        let fileContentVC = UIViewController()
        fileContentVC.view.backgroundColor = .systemBackground
        fileContentVC.title = file.filename ?? "Unknown file"
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Loading data..."
        label.textAlignment = .left
        
        fileContentVC.view.addSubview(scrollView)
        scrollView.addSubview(label)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: fileContentVC.view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: fileContentVC.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: fileContentVC.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: fileContentVC.view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            label.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])

        viewController?.present(fileContentVC, animated: true) {
            DispatchQueue.main.async {
                label.text = file.content ?? "No content"
            }
        }
    }
}
