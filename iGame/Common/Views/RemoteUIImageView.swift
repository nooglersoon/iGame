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
    
    override init(frame: CGRect) {
        super.init(frame: frame) // Call the designated initializer of UIImageView
        // Custom initialization code
        self.backgroundColor = .systemGray3.withAlphaComponent(0.25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from url: URL) {
        currentTask?.cancel() // Cancel any ongoing task
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
