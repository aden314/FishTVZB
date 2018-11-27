//
//  BaseAnchorViewController.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/26.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

let LJ_NORMAL_CELL_ITEM_MARGIN:CGFloat = 10
let LJ_NORMAL_CELL_ITEM_WIDTH:CGFloat = (c_SCREEN_WIDTH - LJ_NORMAL_CELL_ITEM_MARGIN * 3) / 2
let LJ_NORMAL_ITEM_HEIGHT:CGFloat = LJ_NORMAL_CELL_ITEM_WIDTH * 3/4
let LJ_PRETTY_ITEM_HEIGHT:CGFloat = LJ_NORMAL_CELL_ITEM_WIDTH * 4/3
let LJ_NORMAL_CELL_HEADER_HEIGHT:CGFloat = 50

let LJ_NORMAL_CELL_ID = "NormalCellID"
let LJ_PRETTY_CELL_ID = "PrettyCellID"
private let LJ_NORMAL_CELL_HEADER_ID = "CellHeaderID"

class BaseAnchorViewController: UIViewController {
    
    var baseViewModel:BaseViewModel!
    
    lazy var collectionView:UICollectionView = { [unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: LJ_NORMAL_CELL_ITEM_WIDTH, height: LJ_NORMAL_ITEM_HEIGHT)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = LJ_NORMAL_CELL_ITEM_MARGIN
        layout.headerReferenceSize = CGSize(width: c_SCREEN_WIDTH, height: LJ_NORMAL_CELL_HEADER_HEIGHT)
        layout.sectionInset = UIEdgeInsets(top: 0, left: LJ_NORMAL_CELL_ITEM_MARGIN, bottom: 0, right: LJ_NORMAL_CELL_ITEM_MARGIN)
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: LJ_NORMAL_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: LJ_PRETTY_CELL_ID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: LJ_NORMAL_CELL_HEADER_ID)
        
        return collectionView
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
}


extension BaseAnchorViewController{
    @objc func setupUI(){
        self.view.addSubview(collectionView)
    }
    
    @objc func loadData(){
    }
    
}

extension BaseAnchorViewController:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.baseViewModel.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LJ_NORMAL_CELL_ID, for: indexPath) as! CollectionViewNormalCell
        cell.anchor = self.baseViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cellHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: LJ_NORMAL_CELL_HEADER_ID, for: indexPath) as! CollectionHeaderView
        cellHeaderView.group = baseViewModel.anchorGroups[indexPath.section]
        return cellHeaderView
    }
}

extension BaseAnchorViewController:UICollectionViewDelegate{
    
}

