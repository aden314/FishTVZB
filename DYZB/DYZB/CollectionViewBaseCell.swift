//
//  CollectionViewBaseCell.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/21.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewBaseCell: UICollectionViewCell {
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    
    var anchor:AnchorModel? {
        didSet{
            if let anchorModel = anchor{
                self.nicknameLabel.text = anchorModel.nickname
                self.onlineButton.titleLabel?.text = anchorModel.online.changeToChineseCountString()
                self.mainImageView.kf.setImage(with: URL(string: anchorModel.vertical_src),placeholder: UIImage(named: "Img_default"))
            }
        }
    }
    
}
