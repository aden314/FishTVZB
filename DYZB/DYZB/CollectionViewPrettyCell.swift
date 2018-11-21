//
//  CollectionViewPrettyCell.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/16.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewPrettyCell: CollectionViewBaseCell {

    @IBOutlet weak var locationButton: UIButton!
    
    override var anchor:AnchorModel?{
        didSet{
            super.anchor = anchor
            self.locationButton.titleLabel?.text = anchor?.anchor_city
        }
    }

}
