//
//  RecommendViewController.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/15.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

private let LJ_ITEM_MARGIN:CGFloat = 10
private let LJ_ITEM_WIDTH:CGFloat = (c_SCREEN_WIDTH - LJ_ITEM_MARGIN * 3) / 2
private let LJ_NORMAL_ITEM_HEIGHT:CGFloat = LJ_ITEM_WIDTH * 3/4
private let LJ_PRETTY_ITEM_HEIGHT:CGFloat = LJ_ITEM_WIDTH * 4/3
private let LJ_CELL_HEADER_HEIGHT:CGFloat = 50
private let LJ_CYCLE_VIEW_HEIGHT:CGFloat = c_SCREEN_WIDTH * 3/8
private let LJ_GAME_VIEW_HEIGHT:CGFloat = 90

private let LJ_NORMAL_CELL_ID = "NormalCellID"
private let LJ_PRETTY_CELL_ID = "PrettyCellID"
private let LJ_CELL_HEADER_ID = "CellHeaderID"

class RecommendViewController: UIViewController {
    
    private lazy var recommendViewModel = RecommendViewModel()
    private lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: LJ_ITEM_WIDTH, height: LJ_NORMAL_ITEM_HEIGHT)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = LJ_ITEM_MARGIN
        layout.headerReferenceSize = CGSize(width: c_SCREEN_WIDTH, height: LJ_CELL_HEADER_HEIGHT)
        layout.sectionInset = UIEdgeInsets(top: 0, left: LJ_ITEM_MARGIN, bottom: 0, right: LJ_ITEM_MARGIN)
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white       
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: LJ_NORMAL_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: LJ_PRETTY_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LJ_CELL_HEADER_ID)
        return collectionView }()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadData()
    }
}

extension RecommendViewController{
    private func setupUI(){
        self.view.addSubview(collectionView)
        collectionView.addSubview(cycleView)
        collectionView.addSubview(gameView)
        collectionView.contentInset = UIEdgeInsets(top: LJ_CYCLE_VIEW_HEIGHT+LJ_GAME_VIEW_HEIGHT, left: 0, bottom: 0, right: 0)
    }
    
    private func loadData(){
        recommendViewModel.requestData {
            self.collectionView.reloadData()
            self.gameView.anchorGroups = self.recommendViewModel.anchorGroups
        }
        recommendViewModel.requestCycleViewData {
            self.cycleView.cycleModels = self.recommendViewModel.cycleModels
        }
       
    }
    
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendViewModel.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cellHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LJ_CELL_HEADER_ID, for: indexPath) as! CollectionHeaderView
        cellHeaderView.group = recommendViewModel.anchorGroups[indexPath.section]
        return cellHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 1 ? CGSize(width: LJ_ITEM_WIDTH, height: LJ_PRETTY_ITEM_HEIGHT) : CGSize(width: LJ_ITEM_WIDTH, height: LJ_NORMAL_ITEM_HEIGHT)
    }

    
}

