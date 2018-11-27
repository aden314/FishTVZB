//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/15.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titileLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    var group: AnchorGroup? {
        didSet{
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            titileLabel.text = group?.tag_name
        }
    }
}

extension CollectionHeaderView{
    class func creatHeaderView()->CollectionHeaderView{
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
