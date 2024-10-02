//
//  GistListPresenter.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 01.10.2024.
//

import Foundation

protocol GistListPresenterProtocol: AnyObject {
    func loadGists()
    func reloadGists(_ onFetched: (() -> Void)?)
    func didSelectGist(_ gist: Gist)
    func showFetchedGists(gists: [Gist])
}

class GistListPresenter: GistListPresenterProtocol {

    weak var view: GistListViewProtocol?
    var interactor: GistListInteractorProtocol?
    var router: GistListRouterProtocol?
    
    private var page = 1
    private var gists: [Gist] = []
    
    func loadGists() {
        if page < 100 {
            fetchGists()
        }
    }
    
    func reloadGists(_ onFetched: (() -> Void)?) {
        self.gists = []
        page = 1
        interactor?.fetchGists(page: page, onFetched)
    }
    
    private func fetchGists() {
        interactor?.fetchGists(page: page, nil)
    }
    
    func showFetchedGists(gists: [Gist]) {
        self.gists += gists
        view?.showGists(self.gists)
        if page < 100 {
            page += 1
        }
    }
    
    func didSelectGist(_ gist: Gist) {
        router?.navigateToGistDetail(with: gist)
    }
}
