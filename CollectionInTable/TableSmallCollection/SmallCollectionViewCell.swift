//
//  SmallCollectionViewCell.swift
//  CollectionInTable
//
//  Created by 이성민 on 2023/05/15.
//

import UIKit

final class SmallCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "SmallCollectionViewCell"
    
    // MARK: - UI Property
    
    private let colorView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting
    
    private func setLayout() {
        addSubview(colorView)
        colorView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action Helper
    
    
    
    // MARK: - Custom Method
    
    func configureCell(with color: UIColor) {
        colorView.backgroundColor = color
    }
    
}
