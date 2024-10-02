//
//  GistDetailInteractor.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation

protocol GistInfoInteractorProtocol: AnyObject {
    func fetchGistDetails(_ gistId: String)
}

class GistInfoInteractor: GistInfoInteractorProtocol {
    weak var presenter: GistInfoPresenterProtocol?
    private let gist: Gist
    
    init(gist: Gist) {
        self.gist = gist
    }
    
    func fetchGistDetails(_ gistId: String) {
        guard let url = URL(string: "https://api.github.com/gists/\(gistId)") else { return }

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
                let gistInfo = try JSONDecoder().decode(GistInfo.self, from: data)
                self.presenter?.didFetchGistInfo(gistInfo)
            } catch {
                Logger.log(String(describing: error), type: .error)
            }
        }
        task.resume()
    }
}
