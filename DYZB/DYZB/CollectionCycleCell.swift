//
//  CollectionCycleCell.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/23.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionCycleCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var cycleModel:CycleModel?{
        didSet{
            if let model = cycleModel{
                self.titleLabel.text = model.title
                self.imageView.kf.setImage(with: URL(string: model.pic_url))
            }
        }
    }
    
}
