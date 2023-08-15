//
//  GameCardCell.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit

struct GameCardCellModel {
    let title: String
    let description: String
    let rating: Int
}

class GameCardCell: UICollectionViewCell {
    let roundedImageView: RemoteImageView = {
        let imageView = RemoteImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: GameCardCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        ratingLabel.text = "\(model.rating)"
        if let url = URL(string: "https://media.rawg.io/media/games/49c/49c3dfa4ce2f6f140cc4825868e858cb.jpg") {
            roundedImageView.loadImage(from: url)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(roundedImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(ratingLabel)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // Set up constraints for roundedImageView
            roundedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roundedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            roundedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            roundedImageView.widthAnchor.constraint(equalToConstant: 120),
            roundedImageView.heightAnchor.constraint(equalToConstant: 120),
            
            // Set up constraints for stackView
            stackView.leadingAnchor.constraint(equalTo: roundedImageView.trailingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }
}
