//
//  ViewController.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import UIKit

enum Item: Hashable {
    case procedureCard(ProcedureCard)
    case clinicCard(ClinicCard)
}

class HomeViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    var collectionView: UICollectionView! = nil
    
    var procedureViewModel: ProcedureCardViewModel!
    var clinicViewModel: ClinicCardViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "JSU Health"
        configureHierarchy()
        configureDataSource()
    }
}

enum Section: Int, Hashable, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .procedures: return "Procedures"
        case .clinics: return "Clinics"
        }
    }
    
    case procedures, clinics
}

extension HomeViewController {
    
    func createLayout() -> UICollectionViewLayout {
        
        let sectionProvider = { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
        
            let section: NSCollectionLayoutSection
            
            if sectionKind == .procedures {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                            
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                       heightDimension: .absolute(300))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                            
                section = NSCollectionLayoutSection(group: group)
                
                section.interGroupSpacing = 16
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                section.orthogonalScrollingBehavior = .continuous
            } else if sectionKind == .clinics {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                       heightDimension: .absolute(300))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                
                section = NSCollectionLayoutSection(group: group)
                
                section.interGroupSpacing = 16
                
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                
                section.orthogonalScrollingBehavior = .continuous
            } else {
                fatalError("Uknown section!")
            }
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
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
    
    func createProcedureCellRegistration() -> UICollectionView.CellRegistration<ProcedureCell, Item> {
        return UICollectionView.CellRegistration<ProcedureCell, Item> { [self] (cell, indexPath, item) in
            switch item {
            case .procedureCard(let procedureCard):
                cell.setUp(with: procedureCard)
                Task {
                    let (data, response) = await procedureViewModel.makeImageQuery(query: procedureCard.imageName)
                    if (response as? HTTPURLResponse)?.statusCode == 200 {
                        if let data = data {
                            cell.imageView.image = UIImage(data: data)
                        }
                    } else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode
                        print("error fetching data, response: \(statusCode)")
                    }
                }
            case .clinicCard(_):
                break
            }
        }
    }
    
    func createClinicCellRegistration() -> UICollectionView.CellRegistration<ClinicCell, Item> {
        return UICollectionView.CellRegistration<ClinicCell, Item> { [self] (cell, indexPath, item) in
            switch item {
            case .procedureCard(_):
                break
            case .clinicCard(let clinicCard):
                cell.setUp(with: clinicCard)
                Task {
                    let (data, response) = await procedureViewModel.makeImageQuery(query: clinicCard.imageName)
                    if (response as? HTTPURLResponse)?.statusCode == 200 {
                        if let data = data {
                            cell.imageView.image = UIImage(data: data)
                        }
                    } else {
                        let statusCode = (response as? HTTPURLResponse)?.statusCode
                        print("error fetching data, response: \(statusCode)")
                    }
                }
            }
        }
    }
    
    func configureDataSource() {
        
        let procedureCellRegistration = createProcedureCellRegistration()
        let clinicCellRegistration = createClinicCellRegistration()
        
        // data source
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
            case .procedures:
                return collectionView.dequeueConfiguredReusableCell(using: procedureCellRegistration, for: indexPath, item: item)
            case .clinics:
                return collectionView.dequeueConfiguredReusableCell(using: clinicCellRegistration, for: indexPath, item: item)
            }
        }
        
        // set the order of our sections
        
        let sections = Section.allCases
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        dataSource.apply(snapshot, animatingDifferences: false)
        
        // procedure cards
        let procedureCards = procedureViewModel.procedures
        var procedureSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        procedureSnapshot.append(procedureCards)
        dataSource.apply(procedureSnapshot, to: .procedures, animatingDifferences: false)
        
        // clinic cards
        let clinicCards = clinicViewModel.clinics
        var clinicSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
        clinicSnapshot.append(clinicCards)
        dataSource.apply(clinicSnapshot, to: .clinics, animatingDifferences: false)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
