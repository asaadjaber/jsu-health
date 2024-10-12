import UIKit
import SwiftUI

class CalendarViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Int, PlannerItem>!
    private var calendarViewModel: CalendarViewModel!
    private var calendarView = CalendarView()

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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(326))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .estimated(150))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize,
                                                                        elementKind: ElementKind.sectionHeader.rawValue, alignment: .top)
        
        let footerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .estimated(500))
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize,
                                                                        elementKind: ElementKind.sectionFooter.rawValue, alignment: .bottom)
                        
        section.boundarySupplementaryItems = [sectionHeader,
                                              sectionFooter]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}

extension CalendarViewController {
    
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration
        <CalendarCell, PlannerItem> { [self] cell, indexPath, item in
            let calendarHostingController = UIHostingController(rootView: calendarView)
            self.addChild(calendarHostingController)
            calendarHostingController.didMove(toParent: self)
            cell.calendarView = calendarHostingController.view
            cell.configure()
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <CalendarHeaderCell>(elementKind: ElementKind.sectionHeader.rawValue) { supplementaryView, elementKind, indexPath in
            supplementaryView.configure(with: self.calendarViewModel.item)
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <AvailableTimeSlotsCell>(elementKind: ElementKind.sectionFooter.rawValue) { [self] supplementaryView, elementKind, indexPath in
            
            let timeSlots: [TimeSlot]
            switch self.calendarViewModel.item {
            case .doctor(let doctor):
                guard let doctorTimeSlots = doctor.timeSlots else { return }
                timeSlots = doctorTimeSlots
            case .clinic(let clinic):
                guard let clinicTimeSlots = clinic.timeSlots else { return }
                timeSlots = clinicTimeSlots
            }
            let timeSlotsViewModel = TimeSlotsViewModel(timeSlots: timeSlots)
            let viewController = TimeSlotsViewController(timeSlotsViewModel: timeSlotsViewModel)
            supplementaryView.timeSlotsView = viewController.view
            self.addChild(viewController)
            viewController.didMove(toParent: self)
            supplementaryView.addTimeSlotsView()
            
            calendarView.updatedDate = {
                viewController.createAndApplySnapshot(timeSlots: timeSlots)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            guard let viewKind = ElementKind(rawValue: kind) else {
                fatalError("Unknown supplementary view kind")
            }
            
            switch viewKind {
            case .sectionHeader:
                let headerSupplementaryView = self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: index)
                return headerSupplementaryView
            case .sectionFooter:
                let footerSupplementaryView = self.collectionView.dequeueConfiguredReusableSupplementary(using: footerRegistration, for: index)
                return footerSupplementaryView
            }
        }
    }
    
    func createAndApplySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PlannerItem>()
        
        snapshot.appendSections([0])
        snapshot.appendItems([calendarViewModel.item])
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}
