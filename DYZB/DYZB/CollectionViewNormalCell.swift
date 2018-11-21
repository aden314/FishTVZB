//
//  CollectionViewNormalCell.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/16.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionViewBaseCell {

    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    override var anchor:AnchorModel? {
        didSet{
            super.anchor = anchor
            self.roomNameLabel.text = anchor?.room_name
        }
    }
    
    
}
