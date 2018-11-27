//
//  BaseGameModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/25.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    @objc var tag_name:String = ""
    @objc var icon_url:String = ""
    var icon_name = "home_header_normal"
    
    init(tagName:String,iconName:String){
        self.tag_name = tagName
        self.icon_name = iconName
    }
    
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    
}
