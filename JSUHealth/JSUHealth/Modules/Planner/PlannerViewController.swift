import UIKit

enum PlannerItem: Hashable {
    case doctor(Doctor)
    case clinic(Clinic)
}

class PlannerViewController: UIViewController {
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, PlannerItem>!
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        view.backgroundColor = .yellow

        self.collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = #colorLiteral(red: 0.980392158, green: 0.980392158, blue: 0.980392158, alpha: 1)
        
        view.addSubview(collectionView)
        
        registerDataSource()
        createAndApplySnapshot()
    }
    
    private let doctorClinicViewModel: DoctorClinicViewModel
    
    init(doctorClinicViewModel: DoctorClinicViewModel) {
        self.doctorClinicViewModel = doctorClinicViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct ElementKind {
    static let sectionHeader = "section-header-element-kind"
}


extension PlannerViewController {
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(80))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(88))
            
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                        elementKind: ElementKind.sectionHeader,
                                                                         alignment: .top)
        
        sectionHeader.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func registerDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<PlannerCell, PlannerItem> { cell, indexPath, item in
            cell.configure(with: item)
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <HeaderCell>(elementKind: ElementKind.sectionHeader) {
            supplementaryView, string, indexPath in
            
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
        snapshot.appendItems(doctorClinicViewModel.items)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
