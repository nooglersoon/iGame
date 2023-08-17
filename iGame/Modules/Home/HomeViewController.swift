//
//  HomeViewController.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, CardCollectionViewCellModel>!
    
    private let viewModel: HomeViewModel = HomeViewModel()
    
    private let emptyStateView: EmptyStateView = {
        let view = EmptyStateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iGame"
        
        setupViews()
        configureDataSource()
        applyInitialSnapshot()
        observeState()
        
        Task {
            await viewModel.fetchData()
        }
        
    }
    
    // Setup Observers
    
    private func observeState() {
        viewModel.$items
            .sink { [weak self] items in
                guard let self else { return }
                self.applySnapshot(with: items)
                if items.isEmpty {
                    updateEmptyState(showEmptyState: true)
                } else {
                    updateEmptyState(showEmptyState: false)
                }
            }
            .store(in: &cancellables)
    }
    
}

// MARK: Setup DataSource and Layout

private extension HomeViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, CardCollectionViewCellModel>(collectionView: collectionView) {
            (collectionView, indexPath, game) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameCardCell
            if let item = game.item {
                cell.configure(with: .init(
                    title: item.title,
                    releaseDate: item.releaseDate,
                    rating: item.rating,
                    imageUrl: item.imageUrl))
            }
            return cell
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CardCollectionViewCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func applySnapshot(with newItems: [CardCollectionViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CardCollectionViewCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(newItems)
        dataSource.apply(snapshot)
    }
    
    private func setupCollectionView() {
        let layout = createLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.register(GameCardCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    private func setupViews() {
        setupCollectionView()
        emptyStateView.configure(with: "Failed to fetch the data")
        view.addSubview(emptyStateView)
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func updateEmptyState(showEmptyState: Bool){
        DispatchQueue.main.async {
            self.emptyStateView.isHidden = !showEmptyState
        }
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGameViewModel = viewModel.items[indexPath.row]
        if
            let id = selectedGameViewModel.gameId {
            let viewController = GameDetailViewController(id: id)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.checkIfEnableFetchData(currentRow: indexPath.row)
    }
    
}
