//
//  HomeViewController.swift
//  iGame
//
//  Created by Fauzi Achmad B D on 15/08/23.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, HomeViewCellModel>!
    
    let homeService: HomeServiceable
    
    init(service: HomeServiceable) {
        self.homeService = service
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
        
        Task {
            
            let results = await homeService.getGames()
            switch results {
            case .success(let lists):
                if let results = lists.results {
                    let items: [HomeViewCellModel] = results.map { game in
                        return .init(item: game)
                    }
                    applySnapshot(with: items)
                }
            default:
                break
            }
        }
        
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
    
    private func configureDataSource() {
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
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, HomeViewCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems([
            HomeViewCellModel(item: nil),
            HomeViewCellModel(item: nil),
            HomeViewCellModel(item: nil)
        ])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with newItems: [HomeViewCellModel]) {
        let snapshot = dataSource.snapshot()
        var items = snapshot.itemIdentifiers(inSection: 0)
        items = newItems
        var newSnapshot = NSDiffableDataSourceSnapshot<Int, HomeViewCellModel>()
        newSnapshot.appendSections([0])
        newSnapshot.appendItems(items)
        dataSource.apply(newSnapshot)
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedGameViewModel = dataSource.snapshot().itemIdentifiers[indexPath.row]
        if
            let game = selectedGameViewModel.item,
            let id = game.id {
            let viewController = GameDetailViewController(id: id, service: NetworkService.shared)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}
