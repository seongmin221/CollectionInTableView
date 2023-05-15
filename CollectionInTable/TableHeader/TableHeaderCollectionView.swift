//
//  TableHeaderCollectionView.swift
//  CollectionInTable
//
//  Created by 이성민 on 2023/05/16.
//

import UIKit

/// 이전에 말했듯 여기에서는 UICollectionHeaderFooterView 이런게 아닌 그냥 UIView 입니다 ~
/// 여기서도 그냥 평범하게 CollectionView 를 만들어주면 돼요 !
final class TableHeaderCollectionView: UIView {
    
    // MARK: - Property
    
    private let dummyData: [UIColor] = [
        .systemGray,
        .systemGray2,
        .systemGray3,
        .systemGray4,
        .systemGray5
    ]
    
    private enum Size {
        static let cellWidth = 150
        static let cellHeight = 150
    }
    
    // MARK: - UI Property
    
    private let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: Size.cellWidth, height: Size.cellHeight)
        return layout
    }()
    
    private lazy var headerCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: HeaderCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setDelegate()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setDelegate() {
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
    }
    
    private func setLayout() {
        addSubview(headerCollectionView)
        headerCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}


// MARK: - UICollectionViewDelegate extension

extension TableHeaderCollectionView: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDataSource extension

extension TableHeaderCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCollectionViewCell.identifier, for: indexPath) as? HeaderCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureCell(with: dummyData[indexPath.row])
        return cell
    }
    
}
