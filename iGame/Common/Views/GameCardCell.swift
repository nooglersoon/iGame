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
    let releaseDate: String
    let rating: Double
    let imageUrl: String
}

class GameCardCell: UICollectionViewCell {
    let roundedImageView: RemoteImageView = {
        let imageView = RemoteImageView(frame: .zero)
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
    
    let releaseDate: UILabel = {
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
        stackView.spacing = 8
        stackView.alignment = .leading
        return stackView
    }()
    
    let starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = .init(systemName: "star.fill")
        imageView.tintColor = .orange
        return imageView
    }()
    
    let ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
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
        releaseDate.text = "Released on \(model.releaseDate)"
        ratingLabel.text = "\(model.rating)"
        if let url = URL(string: model.imageUrl) {
            roundedImageView.configure(with: url)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(roundedImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(releaseDate)
        ratingStackView.addArrangedSubview(starIcon)
        ratingStackView.addArrangedSubview(ratingLabel)
        stackView.addArrangedSubview(ratingStackView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // Set up constraints for roundedImageView
            roundedImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roundedImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            roundedImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            roundedImageView.widthAnchor.constraint(equalToConstant: 120),
            roundedImageView.heightAnchor.constraint(equalToConstant: 120),
            
            starIcon.widthAnchor.constraint(equalToConstant: 12),
            starIcon.heightAnchor.constraint(equalToConstant: 12),
            
            // Set up constraints for stackView
            stackView.leadingAnchor.constraint(equalTo: roundedImageView.trailingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        ])
    }
}
