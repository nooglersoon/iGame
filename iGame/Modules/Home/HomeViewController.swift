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
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    
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
                    let items: [String] = results.map { game in
                        return game.name ?? ""
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
        collectionView.register(GameCardCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Int, String>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GameCardCell
            cell.configure(with: .init(title: item, description: item, rating: 10))
            return cell
        }
    }
    
    private func applyInitialSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        snapshot.appendSections([0])
        snapshot.appendItems(["Item 1", "Item 2", "Item 3"])
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with newItems: [String]) {
        let snapshot = dataSource.snapshot()
        var items = snapshot.itemIdentifiers(inSection: 0)
        items = newItems
        var newSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
        newSnapshot.appendSections([0])
        newSnapshot.appendItems(items)
        dataSource.apply(newSnapshot)
    }
    
}
