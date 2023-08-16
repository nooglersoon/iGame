//
//  GameDetailViewController.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit

class GameDetailViewController: UIViewController {
    
    let bannerImageView: RemoteImageView = {
        let bannerImageView = RemoteImageView(frame: .zero)
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.clipsToBounds = true
        return bannerImageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return titleLabel
    }()
    
    let releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.font = UIFont.systemFont(ofSize: 18)
        return releaseDateLabel
    }()
    
    let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.font = UIFont.systemFont(ofSize: 16)
        return ratingLabel
    }()
    
    let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 12)
        return descriptionLabel
    }()
    
    
    let id: Int
    let service: GameDetailServiceable
    var game: Game?
    
    init(id: Int, service: GameDetailServiceable) {
        self.id = id
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        title = game?.name ?? ""
        setupNavigationBar()
        
        Task {
            let results = await service.getGameById(id)
            switch results {
            case .success(let game):
                self.game = game
                self.updateUI(with: game)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    private func setupNavigationBar() {
        let loveButton = UIBarButtonItem(
            image: .init(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(loveButtonTapped)
        )
        
        navigationItem.rightBarButtonItem = loveButton
    }
    
    @objc private func loveButtonTapped() {
        // Handle love button tap here
    }
    
    private func setupUI() {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(bannerImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bannerImageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            ratingLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func updateUI(with game: Game) {
        titleLabel.text = game.name
        releaseDateLabel.text = game.released
        ratingLabel.text = "Rating: \(game.rating ?? 0)"
        descriptionLabel.text = game.description
        title = game.name
        if let url = URL(string: game.backgroundImage ?? "") {
            bannerImageView.configure(with: url)
        }
    }
}
