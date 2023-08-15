//
//  RemoteUIImageView.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit

class RemoteImageView: UIImageView {
    private var currentTask: URLSessionDataTask?
    
    func loadImage(from url: URL) {
        currentTask?.cancel() // Cancel any ongoing task
        
        self.backgroundColor = .gray
            .withAlphaComponent(0.25)
        
        currentTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.backgroundColor = nil
                self?.image = image
            }
        }
        
        currentTask?.resume()
    }
}
