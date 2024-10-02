//
//  GistListInteractor.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 01.10.2024.
//

import Foundation

protocol GistListInteractorProtocol: AnyObject {
    func fetchGists(page: Int, _ onFetched: (() -> Void)?)
}

class GistListInteractor: GistListInteractorProtocol {
    weak var presenter: GistListPresenterProtocol?
    
    func fetchGists(page: Int, _ onFetched: (() -> Void)? = nil) {
        guard let url = URL(string: "https://api.github.com/gists/public?page=\(page)") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                Logger.log(error.localizedDescription, type: .error)
                return
            }
            
            guard let data = data else {
                Logger.log("No data in fetchGistDetails response", type: .error)
                return
            }
            
            do {
                let gists = try JSONDecoder().decode([Gist].self, from: data)
                self.presenter?.showFetchedGists(gists: gists)
                onFetched?()
            } catch {
                Logger.log(String(describing: error), type: .error)
                onFetched?()
            }
        }
        task.resume()
    }
}
