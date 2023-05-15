//
//  TableViewCollectionCell.swift
//  CollectionInTable
//
//  Created by 이성민 on 2023/05/15.
//

import UIKit

final class TableViewLargeCollectionCell: UITableViewCell {
    
    // MARK: - Property
    
    /// identifier 는 필수로 필요하져 ?
    static let identifier = "TableViewLargeCollectionCell"
    
    private enum Size {
        static let cellHeight = 80
        static let cellWidth = 80
    }
    
    /// 요 cell 의 LargeCollectionView 에서 사용할 데이터입니당
    /// 처음에는 비어있는데 아래에 선언되어 있는 `prepareCells(with data: )` 가 실행되면 이 변수에 값이 들어갈겁니다
    private var largeDummyData: [UIColor] = []
    
    // MARK: - UI Property
    
    /// collecionView 의 흐름? 레이아웃? 이 어떻게 될 지 결정하는 변수입니다
    /// 여기에서 scroll 방향이든, collectionView 내부의 itemSize 등등을 설정해 두고
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Size.cellWidth, height: Size.cellHeight)
        return layout
    }()
    
    /// 여기 collectionView 를 처음 생성할 때 collectionViewLayout 에다가 넣어주면 해당 layout이 적용 됨 !
    lazy var largeCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        /// 여기에서도 사용할 cell 을 register 해줘야겠쥬 ?
        collectionView.register(LargeCollectionViewCell.self, forCellWithReuseIdentifier: LargeCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setDelegate()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    /// 그냥 똑같이 delegate, dataSource 설정 !
    private func setDelegate() {
        largeCollectionView.delegate = self
        largeCollectionView.dataSource = self
    }
    
    private func setLayout() {
        contentView.addSubview(largeCollectionView)
        largeCollectionView.snp.makeConstraints {
            $0.centerY.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Size.cellHeight)
        }
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    /// MainViewController 에서 Cell 설정해 줄 때 이 함수도 같이 실행시켜줬는데,
    /// MainViewController 에 있는 dummyData 를 TableViewLargeCollectionCell 의 largeDummyData 로 전달해주기 위해 만들었음 !
    func prepareCells(with data: [UIColor]) {
        self.largeDummyData = data
    }
    
}


extension TableViewLargeCollectionCell: UICollectionViewDelegate {
    
}

extension TableViewLargeCollectionCell: UICollectionViewDataSource {
    
    /// section 에 몇 개의 cell 이 있는지 설정해주는 함수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return largeDummyData.count
    }
    
    /// cell 이 어떤 놈인지 설정해주는 함수
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /// register 해 둔 LargeCollectionViewCell 을 deque 해서 사용하는 것 !
        /// 여기서도 마찬가지로 다운캐스팅 ( as? ) 는 필요 !
            /// 참고로 다운캐스팅이란 타입을 변환해주는 것
            /// 이걸 하는 이유는 LargeCollectionViewCell 클래스 내부에 선언된 함수 ( configureCell() ) 을 cell 에서 사용하기 위해서임 !
            /// 그리고 as 에 ? 를 붙이는 이유는 타입을 변환하는건데, 변환이 안 될 가능성도 있기 때문
            /// 예를 들어서 String 으로 되어 있는 'a' 를 Int 로 다운캐스팅 할 수 없는 것과 비슷한 맥락
        /// configureCell() 함수는 말 그대로 cell 에 대한 설정들을 만들어주는 것
        /// 이젠 `LargeCollectionViewCell` 파일로 넘어갑시다 !
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LargeCollectionViewCell.identifier, for: indexPath) as? LargeCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(with: largeDummyData[indexPath.row])
        return cell
    }
    
}

