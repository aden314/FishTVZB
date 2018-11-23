//
//  RecommendGameView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/23.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

private let LJ_GAME_VIEW_CELL = "LJ_GAME_VIEW_CELL"
private let LJ_INSET_MARGIN:CGFloat = 10

class RecommendGameView: UIView {
    
    var anchorGroups:[AnchorGroup]?{
        didSet{
            anchorGroups?.remove(at: 0)
            anchorGroups?.remove(at: 0)
            
            let moreGroup = AnchorGroup(tagName: "更多", iconName: "")
            anchorGroups?.append(moreGroup)
            
            self.collectionView.reloadData()
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        self.autoresizingMask = .init(rawValue: 0)
        self.collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: LJ_GAME_VIEW_CELL)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: LJ_INSET_MARGIN, bottom: 0, right: LJ_INSET_MARGIN)
        
    }
    
}

extension RecommendGameView{
    class func creatRecommendGameView()->RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

extension RecommendGameView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_GAME_VIEW_CELL, for: indexPath) as! CollectionGameCell
        cell.anchorGroup = anchorGroups?[indexPath.item]
        return cell
    }
    
    
}
