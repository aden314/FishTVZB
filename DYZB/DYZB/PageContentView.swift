//
//  PageContentView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/7.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate:class {
    func contentIndexChanged(withContentView: PageContentView, progress:CGFloat, sourceIndex:Int, targetIndex:Int)
}

class PageContentView: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
   
    let C_COLLECTIONVIEW_CELL_ID = "CollectionCellID"
    
    weak var delegate:PageContentViewDelegate?
    private var isForbidScrollDelegate:Bool = false
    private var subViewControllers:[UIViewController]
    private weak var parentViewController:UIViewController?
    private var startOffsetX:CGFloat = 0
    private lazy var collectionView:UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: C_COLLECTIONVIEW_CELL_ID)
        collectionView.delegate = self
        return collectionView
    }()

    init(frame: CGRect,subViewControllers:[UIViewController], parentViewController:UIViewController?) {
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
            parentViewController?.addChild(subViewController)
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
    
    func setCurrentContentIndex(_ currentIndex:Int){
        isForbidScrollDelegate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        self.startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {return}
        
        var progress : CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewWidth = scrollView.bounds.width
        
        if currentOffsetX >= self.startOffsetX {
            progress = currentOffsetX.truncatingRemainder(dividingBy: scrollViewWidth) / scrollViewWidth
            sourceIndex = Int(currentOffsetX / scrollViewWidth)
            targetIndex = (sourceIndex + 1) >= subViewControllers.count ? sourceIndex : (sourceIndex + 1)
            if (currentOffsetX - startOffsetX) == scrollViewWidth {
                progress = 1
                targetIndex = sourceIndex
            }
        }else{
            progress = 1 - currentOffsetX.truncatingRemainder(dividingBy: scrollViewWidth) / scrollViewWidth
            targetIndex = Int(currentOffsetX / scrollViewWidth)
            sourceIndex = targetIndex + 1
        }
        
        delegate?.contentIndexChanged(withContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}
