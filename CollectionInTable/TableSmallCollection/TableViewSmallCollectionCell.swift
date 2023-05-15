//
//  TableViewSmallCollectionCell.swift
//  CollectionInTable
//
//  Created by 이성민 on 2023/05/15.
//

import UIKit

final class TableViewSmallCollectionCell: UITableViewCell {
    
    // MARK: - Property
    
    static let identifier = "TableViewSmallCollectionCell"
    
    private enum Size {
        static let cellHeight = 40
        static let cellWidth = 40
    }
    
    private var smallDummyData: [UIColor] = []
    
    // MARK: - UI Property
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Size.cellWidth, height: Size.cellHeight)
        return layout
    }()
    
    lazy var smallCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SmallCollectionViewCell.self, forCellWithReuseIdentifier: SmallCollectionViewCell.identifier)
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
    
    private func setDelegate() {
        smallCollectionView.delegate = self
        smallCollectionView.dataSource = self
    }
    
    private func setLayout() {
        contentView.addSubview(smallCollectionView)
        smallCollectionView.snp.makeConstraints {
            $0.centerY.horizontalEdges.equalToSuperview()
            $0.height.equalTo(Size.cellHeight)
        }
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    func prepareCells(with data: [UIColor]) {
        self.smallDummyData = data
    }
    
}


extension TableViewSmallCollectionCell: UICollectionViewDelegate {
    
}

extension TableViewSmallCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return smallDummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCollectionViewCell.identifier, for: indexPath) as? SmallCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(with: smallDummyData[indexPath.row])
        return cell
    }
    
}
