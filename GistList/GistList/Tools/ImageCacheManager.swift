//
//  ImageCacheManager.swift
//  GistList
//
//  Created by Stepan Chernovskiy on 02.10.2024.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = ImageCacheManager()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = cache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data, let image = UIImage(data: data) {
                self?.cache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}
