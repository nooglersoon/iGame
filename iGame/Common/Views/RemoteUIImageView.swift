//
//  RemoteUIImageView.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit

class RemoteImageView: UIImageView {
    
    private var imageCache: [URL: UIImage] = [:]
    
    private var currentTask: URLSessionDataTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame) // Call the designated initializer of UIImageView
        // Custom initialization code
        self.backgroundColor = .systemGray3.withAlphaComponent(0.25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(with url: URL, completion: @escaping (UIImage?) -> Void) {
        // Check if the image is already in the cache
        if let cachedImage = imageCache[url] {
            completion(cachedImage)
            return
        }
        
        // Image is not in the cache, fetch it from the network
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            // Store the image in the cache
            self.imageCache[url] = image
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
    
    func configure(with imageURL: URL) {
        loadImage(with: imageURL) { [weak self] image in
            self?.image = image
        }
    }
    
}
