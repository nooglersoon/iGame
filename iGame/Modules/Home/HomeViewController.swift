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
    private var dataSource: UICollectionViewDiffableDataSource<Int, HomeViewCellModel>!
    
    private let viewModel: HomeViewModel = HomeViewModel()
    
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
        
        setupCollectionView()
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
            }
            .store(in: &cancellables)
    }
    
}

// MARK: Setup DataSource and Layout

private extension HomeViewController {
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, HomeViewCellModel>(collectionView: collectionView) {
            (collectionView, indexPath, game) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameCardCell
            if let item = game.item {
                cell.configure(with: .init(
                    title: item.name ?? "",
                    releaseDate: item.released ?? "",
                    rating: item.rating ?? 0,
                    imageUrl: item.backgroundImage ?? ""))
            }
            return cell
        }
    }
    
    func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeViewCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func applySnapshot(with newItems: [HomeViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeViewCellModel>()
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
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(150))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
}

// MARK: UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGameViewModel = viewModel.items[indexPath.row]
        if
            let game = selectedGameViewModel.item,
            let id = game.id {
            let viewController = GameDetailViewController(id: id)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.checkIfEnableFetchData(currentRow: indexPath.row)
    }
    
}
