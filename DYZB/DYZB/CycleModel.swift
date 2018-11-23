//
//  CycleModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/21.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    @objc var title:String = ""
    @objc var pic_url:String = ""
    @objc var room:[String:Any]? {
        didSet{
            if let dict = room {
                anchor = AnchorModel(dict: dict)
            }
        }
    }
    
    var anchor:AnchorModel?
    
    init(dict:[String:Any]){
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
