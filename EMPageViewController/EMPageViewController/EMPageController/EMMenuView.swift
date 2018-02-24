//
//  EMMenuView.swift
//  EMPageViewController
//
//  Created by 梁亦明 on 2018/2/24.
//  Copyright © 2018年 com.eamon. All rights reserved.
//

import UIKit

@objc protocol EMMenuDataSource {
    
    // 返回标题数量
    func numberOfTitlesInMenuView(menuView: EMMenuView) -> Int
    
    // TODO:返回标题
    @objc optional func menuView(menuView: EMMenuView, titleAtIndex: Int) -> NSString
    
    // 返回自定义的view
    func menuView(menuView: EMMenuView, titleViewAtIndex: Int) -> UIView
}

class EMMenuView: UIView {
    
    // MARK: ***** LifeCycle *****
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = bounds
    }
    
    // MARK: ***** Public Property *****
    
    public weak var dataSource: EMMenuDataSource?
    
    // MARK: ***** Private Property *****
    
    private var itemCount: Int {
        get {
            guard dataSource != nil else { return 0 }
            
            if responds(to: Selector(("numberOfTitlesInMenuView:"))) {
                
                let count = dataSource!.numberOfTitlesInMenuView(menuView: self)
                
                return max(0, count)
            }
            return 0
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
}

// MARK: ***** UICollectionViewDelegate | UICollectionViewDataSource *****
extension EMMenuView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        let item = dataSource!.menuView(menuView: self, titleViewAtIndex: indexPath.row)
        item.frame = cell.bounds
        cell.addSubview(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = dataSource?.menuView(menuView: self, titleViewAtIndex: indexPath.row)
        if let item = item {
            return item.frame.size
        } else {
            return CGSize.zero
        }
    }
}

// MARK: ***** Private Methods *****
extension EMMenuView {
    
    /// 初始化view
    private func initView() {
        
        addSubview(collectionView)
        
    }
    
}
