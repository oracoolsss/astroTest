//
//  GistListRouter.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 01.10.2024.
//

import Foundation
import UIKit

protocol GistListRouterProtocol: AnyObject {
    func navigateToGistDetail(with gist: Gist)
}

class GistListRouter: GistListRouterProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = GistListViewController()
        let interactor = GistListInteractor()
        let presenter = GistListPresenter()
        let router = GistListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToGistDetail(with gist: Gist) {
        let gistDetailVC = GistInfoRouter.createModule(gist: gist)
        viewController?.navigationController?.pushViewController(gistDetailVC, animated: true)
        Logger.log("Navigate to gist: \(gist.id)", type: .info)
    }
}
