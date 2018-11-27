//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGameModel {
    
    @objc var room_list: [[String:Any]]?{
        didSet{
            if let roomList = room_list {
                roomList.forEach { (dict) in
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    
    lazy var anchors:[AnchorModel] = [AnchorModel]()
 
}
