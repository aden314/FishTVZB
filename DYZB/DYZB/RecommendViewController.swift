//
//  RecommendViewController.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/15.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit
private let LJ_CYCLE_VIEW_HEIGHT:CGFloat = c_SCREEN_WIDTH * 3/8
private let LJ_GAME_VIEW_HEIGHT:CGFloat = 90


class RecommendViewController: BaseAnchorViewController {
    
    private lazy var recommendViewModel = RecommendViewModel()
    private lazy var cycleView:RecommendCycleView = {
        let cycleView = RecommendCycleView.creatRecommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(LJ_CYCLE_VIEW_HEIGHT + LJ_GAME_VIEW_HEIGHT), width:c_SCREEN_WIDTH, height: LJ_CYCLE_VIEW_HEIGHT)
        return cycleView
    }()
    private lazy var gameView:RecommendGameView = {
        let gameView = RecommendGameView.creatRecommendGameView()
        gameView.frame = CGRect(x: 0, y: -LJ_GAME_VIEW_HEIGHT, width: c_SCREEN_WIDTH, height: LJ_GAME_VIEW_HEIGHT)
        return gameView
    }()
}

extension RecommendViewController{
    override func setupUI(){
        super.setupUI()
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: LJ_CYCLE_VIEW_HEIGHT+LJ_GAME_VIEW_HEIGHT, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData(){
        self.baseViewModel = recommendViewModel
        recommendViewModel.requestData {
            self.collectionView.reloadData()
            var groups = self.recommendViewModel.anchorGroups
            groups.remove(at: 0)
            groups.remove(at: 0)
            let moreGroup = AnchorGroup(tagName: "更多", iconName: "")
            groups.append(moreGroup)
            self.gameView.groups = groups
        }
        recommendViewModel.requestCycleViewData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
    }
}

extension RecommendViewController:UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let anchorModel = recommendViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        let cell:CollectionViewBaseCell
        
        if indexPath.section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_PRETTY_CELL_ID, for: indexPath) as! CollectionViewPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_NORMAL_CELL_ID, for: indexPath) as! CollectionViewNormalCell
        }
        cell.anchor = anchorModel
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 1 ? CGSize(width: LJ_NORMAL_CELL_ITEM_WIDTH, height: LJ_PRETTY_ITEM_HEIGHT) : CGSize(width: LJ_NORMAL_CELL_ITEM_WIDTH, height: LJ_NORMAL_ITEM_HEIGHT)
    }
}

