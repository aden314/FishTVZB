//
//  AnchorGroup.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    @objc var room_list: [[String:Any]]?{
        didSet{
            if let roomList = room_list {
                roomList.forEach { (dict) in
                    anchors.append(AnchorModel(dict: dict))
                }
            }
        }
    }
    @objc var tag_name = ""
    @objc var icon_url = ""
    var icon_name = "home_header_normal"
    lazy var anchors:[AnchorModel] = [AnchorModel]()
    
    init(tagName:String,iconName:String){
        self.tag_name = tagName
        self.icon_name = iconName
    }
    
    init(dict: [String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
    
}
