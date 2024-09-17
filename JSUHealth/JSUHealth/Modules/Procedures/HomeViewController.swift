//
//  ViewController.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import UIKit

class HomeViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, ProcedureCard>! = nil
    var collectionView: UICollectionView! = nil
    
    var procedureViewModel: ProcedureCardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "JSU Health"
        configureHierarchy()
        configureDataSource()
    }
}

extension HomeViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.66),
                                                  heightDimension: .fractionalHeight(1.0))
                        
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(350))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.orthogonalScrollingBehavior = .continuous
            
            return section
            
        }
        return layout
    }
}

extension HomeViewController {
        
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<ProcedureCell, ProcedureCard> { [self] (cell, indexPath, item) in
            cell.setUp(with: procedureViewModel.procedures[indexPath.row])
        }
        
        dataSource = UICollectionViewDiffableDataSource<Int, ProcedureCard>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        //initial data
        var snapshot = NSDiffableDataSourceSnapshot<Int, ProcedureCard>()
        snapshot.appendSections([0])
        dataSource.apply(snapshot, animatingDifferences: false)
        
        //
        var procedureCards = procedureViewModel.procedures
        var procedureSnapshot = NSDiffableDataSourceSectionSnapshot<ProcedureCard>()
        procedureSnapshot.append(procedureCards)
        dataSource.apply(procedureSnapshot, to: 0, animatingDifferences: false)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
