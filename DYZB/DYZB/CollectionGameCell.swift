//
//  CollectionGameCell.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/23.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionGameCell: UICollectionViewCell {
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var anchorGroup:AnchorGroup?{
        didSet{
            if let group = anchorGroup{
                self.titleLabel.text = group.tag_name
                self.iconImageView.kf.setImage(with: URL(string: group.icon_url),placeholder:UIImage(named: "home_more_btn"))
            }
        }
    }

}
