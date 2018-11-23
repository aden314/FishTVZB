//
//  RecommendCycleView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/21.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

private let LJ_CYCLE_CELL_ID = "LJ_CYCLE_CELL_ID"

class RecommendCycleView: UIView {

    private var cycleTimer:Timer?
    var cycleModels:[CycleModel]?{
        didSet{
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = cycleModels?.count ?? 0
            let indexPath = IndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            self.removeCycleTimer()
            self.addCycleTimer()
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = .init(rawValue: 0)
        self.collectionView.register(UINib(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: LJ_CYCLE_CELL_ID)
        self.collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
    }

}

//Sub-Main
extension RecommendCycleView{
    class func creatRecommendCycleView()->RecommendCycleView{
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// Timer
extension RecommendCycleView{
    private func addCycleTimer(){
        cycleTimer = Timer(timeInterval: 2.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: RunLoop.Mode.default)
    }
    
    private func removeCycleTimer(){
        cycleTimer?.invalidate()
        cycleTimer = nil
    }
    
    @objc private func scrollToNext(){
        let currentOffsetX = collectionView.contentOffset.x
        let offsetX = currentOffsetX + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}

// DataSource
extension RecommendCycleView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_CYCLE_CELL_ID, for: indexPath) as! CollectionCycleCell
        cell.cycleModel = self.cycleModels?[indexPath.item % cycleModels!.count]
        return cell
    }
}

// Delegate
extension RecommendCycleView:UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int((scrollView.contentOffset.x + scrollView.bounds.width/2) / scrollView.bounds.width) % (cycleModels?.count ?? 1)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeCycleTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addCycleTimer()
    }
    
}
