import UIKit

class TimeSlotsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var timeSlotsViewModel: TimeSlotsViewModel!
    private var dataSource: UICollectionViewDiffableDataSource<Int, TimeSlot>!
    var didCall = false

    override func viewDidLoad() {
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .magenta
        configureDataSource()
        createAndApplySnapshot(timeSlots: timeSlotsViewModel.timeSlots)
    }
    
    init(timeSlotsViewModel: TimeSlotsViewModel) {
        self.timeSlotsViewModel = timeSlotsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension TimeSlotsViewController {
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <TimeSlotCell, TimeSlot> { [self] cell, indexPath, item in
            cell.configureWith(timeSlot: timeSlotsViewModel.timeSlots[indexPath.row])
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
    
    func createAndApplySnapshot(timeSlots: [TimeSlot]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, TimeSlot>()
        
        snapshot.appendSections([0])
        snapshot.appendItems(timeSlots)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

