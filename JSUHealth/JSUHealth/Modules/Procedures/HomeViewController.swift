//
//  ViewController.swift
//  JSUHealth
//
//  Created by Asaad Jaber on 16/09/2024.
//

import UIKit
import SwiftUI

enum Item: Hashable {
    case procedureCard(ProcedureCard)
    case clinicCard(ClinicCard)
}

class HomeViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Section, Item>! = nil
    var collectionView: UICollectionView! = nil
    
    var priceTextViewController: UIViewController!
    
    var procedureViewModel: ProcedureCardViewModel!
    var clinicViewModel: ClinicCardViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "JSU Health"
        configureHierarchy()
        configureDataSource()
        
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }

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
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(200),
                                                   heightDimension: .absolute(200))
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            
            section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 16
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            
            section.orthogonalScrollingBehavior = .groupPaging
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                    elementKind: "section-header-element-kind",
                                                                    alignment: .top)
            
            section.boundarySupplementaryItems = [sectionHeader]
            
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
                let priceTextViewController = UIHostingController(rootView: CaptionTextView(title: "From $\(String(procedureCard.price))", cellSize: cell.frame.size))
                priceTextViewController.view.backgroundColor = .clear
                addChild(priceTextViewController)
                priceTextViewController.didMove(toParent: self)
                cell.priceTextView = priceTextViewController.view

                let procedureLabelsViewController = UIHostingController(rootView: ProcedureLabelsView(procedures: procedureCard.procedures, size: cell.frame.size, title: procedureCard.imageName))
                procedureLabelsViewController.view.backgroundColor = .clear
                addChild(priceTextViewController)
                procedureLabelsViewController.didMove(toParent: self)
                cell.procedureLabelsView = procedureLabelsViewController.view

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
                let viewController = UIHostingController(rootView: ClinicLocationTitleView(location: clinicCard.location))
                cell.locationView = viewController.view
                viewController.view.backgroundColor = .clear
                self.addChild(viewController)
                viewController.didMove(toParent: self)
                
                let captionViewController = UIHostingController(rootView: CaptionTextView(title: clinicCard.name, cellSize: cell.frame.size))
                cell.nameLabel = captionViewController.view
                captionViewController.view.backgroundColor = .clear
                self.addChild(captionViewController)
                captionViewController.didMove(toParent: self)
                
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
    
    func createHeaderRegistration() -> UICollectionView.SupplementaryRegistration<ProceduresHeaderView> {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <ProceduresHeaderView>(elementKind: "section-header-element-kind") {
            (supplementaryView, string, indexPath) in
            supplementaryView.sectionIndex = indexPath.section
            supplementaryView.setupView(with: Section.allCases[indexPath.section].description)
        }
        return headerRegistration
    }
    
    func configureDataSource() {
        
        let procedureCellRegistration = createProcedureCellRegistration()
        let clinicCellRegistration = createClinicCellRegistration()
        let headerRegistration = createHeaderRegistration()
        
        // data source
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section") }
            
            switch section {
            case .procedures:
                let cell = collectionView.dequeueConfiguredReusableCell(using: procedureCellRegistration, for: indexPath, item: item)
                return cell
            case .clinics:
                let cell = collectionView.dequeueConfiguredReusableCell(using: clinicCellRegistration, for: indexPath, item: item)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            let cell = self.collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: index)
            return cell
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
