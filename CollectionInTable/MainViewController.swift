//
//  MainViewController.swift
//  CollectionInTable
//
//  Created by 이성민 on 2023/05/15.
//

/// 먼저 설명에 들어가기 전에, 컨벤션도 맞춰뒀다고 지난번에 말했는데,
/// 웬만한 코드 컨벤션들은 /// 가 없을 때로 가정하면 될 것 같아유
/// /// 이 4 줄 있으면 그만큼 위로 이동한다고 보면 될 것 같습니다 ~


import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - Property
    
    /// cell 안에 들어갈 더미 데이터들
    /// 2차원 배열로 만든 이유는 section 구분을 편하게 하기 위해서 !
    /// dummyData[0] 의 색들은 section 0 에 들어가고
    /// dummyData[1] 의 색들은 section 1 에 들어갈 것임 !
    let dummyData: [[UIColor]] = [
        [
            .systemRed,
            .systemBlue,
            .systemCyan,
            .systemPink,
            .systemTeal,
            .systemBrown,
            .systemGray2,
            .systemYellow,
            .systemCyan
        ],
        [
            .systemFill,
            .systemGray,
            .systemMint,
            .systemPink,
            .systemGreen,
            .systemOrange,
            .systemPurple
        ]
    ]
    
    // MARK: - UI Property
    
    /// 우리가 사용할 main tableView -> 이 tableView 의 cell 안에 collectionView 들이 들어갈 것임 !
    /// TableViewLargeCollectionCell 과 TableViewSmallCollectionCell 를 register 해주어야지 dequeReusableCell 을 통해 사용할 수 있음 !
    private let collectionTableView: UITableView = {
        let tableView = UITableView()
        /// tableView 에는 tableHeaderView 가 내장되어 있는데,
        /// 그걸 위한 headerView 를 선언하는 부분입니다
        let headerView = TableHeaderCollectionView()
        /// 저도 처음 알았는데 headerView를 쓸 때에는 frame 을 따로 지정해줘야 하네요 ??
        /// width 는 스크린 전체의 width 로 잡았고, 높이는 그냥 제가 원하는 임의의 값으로 했습니다 ~
        headerView.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        /// 개인적으로 tableView 에 내장되어 있는 seperator 를 안좋아해서.. 없앴숩니다
        tableView.separatorStyle = .none
        /// 아래 코드로 tableView 의 tableHeaderView 를 지정할 수 있습니다
        /// 여기서 tableHeaderView 는 그냥 UIView 타입이기 때문에
        /// headerView 도 UIView 를 상속하는 어떠한 View 든 들어갈 수 있을거에요 ~
        tableView.tableHeaderView = headerView
        tableView.register(TableViewLargeCollectionCell.self, forCellReuseIdentifier: TableViewLargeCollectionCell.identifier)
        tableView.register(TableViewSmallCollectionCell.self, forCellReuseIdentifier: TableViewSmallCollectionCell.identifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()
        setLayout()
    }
    
    // MARK: - Setting
    
    /// delegate 랑 dataSource 설정은 당근빠따 필요한거겠죠 ~?
    private func setDelegate() {
        collectionTableView.delegate = self
        collectionTableView.dataSource = self
    }
    
    private func setLayout() {
        view.addSubview(collectionTableView)
        collectionTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
}


// MARK: - UITableViewDelegate extension

extension MainViewController: UITableViewDelegate {
    
    /// row 의 높이를 설정해주지 않아도 돌아가긴 하는데 height 를 다른데에서 설정해주긴 해야함
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

 // MARK: - UITableViewDataSource extension

extension MainViewController: UITableViewDataSource {
    
    /// section 이 몇 개인지 알려주는 함수
    /// 이거 때문에 dummyData 를 2차원 배열로 선언해 뒀음 !
    /// .count 로 접근하면 편리하기 때문 !
    func numberOfSections(in tableView: UITableView) -> Int {
        return dummyData.count
    }
    
    /// 여기는 사실 그냥 return 1 해도 되는데, 굳이 switch - case 문으로 한 이유는 확장성이 용이해서 ! section 의 개수가 늘어나면 더 편리해서 !
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        default: return 0
        }
    }
    
    /// tableView 의 row 의 cell 을 설정해주는 함수 !
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// smallCollectionView 가 있고, largeCollectionView 가 있는데, 둘 다 deque 해야지 사용할 수 있겠져 ?? 다운캐스팅 ( as? ) 도 필요하구여
        guard let smallCollectionCell = tableView.dequeueReusableCell(withIdentifier: TableViewSmallCollectionCell.identifier) as? TableViewSmallCollectionCell,
              let largeCollectionCell = tableView.dequeueReusableCell(withIdentifier: TableViewLargeCollectionCell.identifier) as? TableViewLargeCollectionCell
        else { return UITableViewCell() }
        
        /// tableView 의 row 를 선택하지 못하게 하는 놈입니다이
        smallCollectionCell.selectionStyle = .none
        largeCollectionCell.selectionStyle = .none
        
        /// section 별로 어떤 cell 을 쓸 지 설정하는 부분입니데이
        /// section 0 에서는 smallCollectionView 를 넣을거고
        /// section 1 에서는 largeCollectionView 를 넣을겨
        /// 여기에 `prepareCells()` 가 있는 이유는 각 collectionView 에 필요한 데이터들을 전달하기 위해 !
        switch indexPath.section {
        case 0:
            smallCollectionCell.prepareCells(with: dummyData[indexPath.section])
            return smallCollectionCell
        case 1:
            largeCollectionCell.prepareCells(with: dummyData[indexPath.section])
            return largeCollectionCell
        default:
            return UITableViewCell()
        }
    }
    
}
