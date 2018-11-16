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

private let LJ_NORMAL_CELL_ID = "NormalCellID"
private let LJ_PRETTY_CELL_ID = "PrettyCellID"
private let LJ_CELL_HEADER_ID = "CellHeaderID"

class RecommendViewController: UIViewController {
    
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
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: LJ_NORMAL_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: LJ_NORMAL_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: LJ_PRETTY_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LJ_CELL_HEADER_ID)
        return collectionView }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
}

extension RecommendViewController{
    private func setupUI(){
        self.view.addSubview(collectionView)
    }
}

extension RecommendViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {return 8}
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = indexPath.section == 1 ? LJ_PRETTY_CELL_ID : LJ_NORMAL_CELL_ID
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cellHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LJ_CELL_HEADER_ID, for: indexPath)
        return cellHeaderView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.section == 1 ? CGSize(width: LJ_ITEM_WIDTH, height: LJ_PRETTY_ITEM_HEIGHT) : CGSize(width: LJ_ITEM_WIDTH, height: LJ_NORMAL_ITEM_HEIGHT)
    }
    
}

