//
//  GameViewController.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/25.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

private let LJ_GAME_CELL_EDGE_MARGIN:CGFloat = 10
private let LJ_GAME_CELL_ITEM_WIDTH:CGFloat = (c_SCREEN_WIDTH - 2 * LJ_GAME_CELL_EDGE_MARGIN)/3
private let LJ_GAME_CELL_ITEM_HEIGHT:CGFloat = LJ_GAME_CELL_ITEM_WIDTH * 6/5
private let LJ_GAME_VIEW_HEIGHT:CGFloat = 90
private let LJ_GAME_CELL_HEADER_HEIGHT:CGFloat = 50

private let LJ_GAME_CELL_ID = "LJ_GAME_CELL_ID"
private let LJ_GAME_HEADER_ID = "LJ_GAME_HEADER_VIEW_ID"

class GameViewController: UIViewController {
    
    private lazy var gameViewModel = GameViewModel()
    private lazy var collectionView:UICollectionView = { [unowned self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: LJ_GAME_CELL_ITEM_WIDTH, height: LJ_GAME_CELL_ITEM_HEIGHT)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: LJ_GAME_CELL_EDGE_MARGIN, bottom: 0, right: LJ_GAME_CELL_EDGE_MARGIN)
        layout.headerReferenceSize = CGSize(width: c_SCREEN_WIDTH, height: LJ_GAME_CELL_HEADER_HEIGHT)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: LJ_GAME_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LJ_GAME_HEADER_ID)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        
        return collectionView
    }()
    private lazy var topHeaderView:CollectionHeaderView = {
        let topHeaderView = CollectionHeaderView.creatHeaderView()
        topHeaderView.titileLabel.text = "常见"
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.moreButton.isHidden = true
        topHeaderView.frame = CGRect(x: 0, y: -(LJ_GAME_CELL_HEADER_HEIGHT + LJ_GAME_VIEW_HEIGHT), width: c_SCREEN_WIDTH, height: LJ_GAME_CELL_HEADER_HEIGHT)
        return topHeaderView
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

extension GameViewController{
    
    private func setupUI(){
        self.view.addSubview(collectionView)
        self.collectionView.addSubview(topHeaderView)
        self.collectionView.addSubview(gameView)
        self.collectionView.contentInset = UIEdgeInsets(top: LJ_GAME_CELL_HEADER_HEIGHT + LJ_GAME_VIEW_HEIGHT, left: 0, bottom: 0, right: 0)
    }
    
    private func loadData(){
        gameViewModel.requestAllGameData {
            self.collectionView.reloadData()
            self.gameView.groups = Array(self.gameViewModel.gameModels[0...10])
        }
    }
}

extension GameViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameViewModel.gameModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_GAME_CELL_ID, for: indexPath) as! CollectionGameCell
        cell.baseGameModel = self.gameViewModel.gameModels[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LJ_GAME_HEADER_ID, for: indexPath) as! CollectionHeaderView
        headerView.titileLabel.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreButton.isHidden = true
        return headerView
    }
    
    
}
