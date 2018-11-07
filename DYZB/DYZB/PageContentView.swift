//
//  PageContentView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/7.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class PageContentView: UIView,UICollectionViewDataSource {
   
    let C_COLLECTIONVIEW_CELL_ID = "CollectionCellID"
    
    private var subViewControllers:[UIViewController]
    private var parentViewController:UIViewController
    private lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: C_COLLECTIONVIEW_CELL_ID)
        return collectionView
    }()

    init(frame: CGRect,subViewControllers:[UIViewController],parentViewController:UIViewController) {
        self.subViewControllers = subViewControllers
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        for subViewController in subViewControllers{
            parentViewController.addChild(subViewController)
        }
        self.addSubview(collectionView)
        collectionView.frame = self.bounds
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subViewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: C_COLLECTIONVIEW_CELL_ID, for: indexPath)
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let subView = subViewControllers[indexPath.item]
        subView.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(subView.view)
        return cell
    }
    
    
}
