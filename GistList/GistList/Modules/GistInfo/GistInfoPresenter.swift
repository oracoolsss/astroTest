//
//  GistDetailPresenter.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation

protocol GistInfoPresenterProtocol: AnyObject {
    func viewDidLoad(_ gistId: String)
    func refreshGistInfo(_ gistId: String)
    func didFetchGistInfo(_ gist: GistInfo)
    func didSelectFile(from gist: GistInfoFile)
}

class GistInfoPresenter: GistInfoPresenterProtocol {
    weak var view: GistInfoViewProtocol?
    var interactor: GistInfoInteractorProtocol?
    var router: GistInfoRouterProtocol?
    
    func viewDidLoad(_ gistId: String) {
        interactor?.fetchGistDetails(gistId)
    }
    
    func refreshGistInfo(_ gistId: String) {
        interactor?.fetchGistDetails(gistId)
    }
    
    func didFetchGistInfo(_ gist: GistInfo) {
        view?.showGistInfo(with: gist)
    }
    
    func didSelectFile(from gist: GistInfoFile) {
        router?.presentFileContent(from: gist)
    }
}
