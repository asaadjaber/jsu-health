import UIKit
import SwiftUI

class CalendarViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, PlannerItem>!
    private var calendarViewModel: CalendarViewModel!

    init(calendarViewModel: CalendarViewModel) {
        self.calendarViewModel = calendarViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        view.backgroundColor = .white
        configureDataSource()
        createAndApplySnapshot()
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                        elementKind: ElementKind.sectionHeader, alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension CalendarViewController {
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<CalendarCell, PlannerItem> { cell, indexPath, item in
            let calendarView = CalendarView()
            let calendarHostingController = UIHostingController(rootView: calendarView)
            self.addChild(calendarHostingController)
            calendarHostingController.didMove(toParent: self)
            cell.calendarView = calendarHostingController.view
            cell.configure()
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration<CalendarHeaderCell>(elementKind: ElementKind.sectionHeader) { supplementaryView, elementKind, indexPath in
            supplementaryView.configure(with: self.calendarViewModel.item)
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
    }
    
    func createAndApplySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PlannerItem>()
        
        snapshot.appendSections([0])
        snapshot.appendItems([calendarViewModel.item])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

