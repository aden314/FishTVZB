//
//  BaseViewModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/26.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class BaseViewModel{
    lazy var anchorGroups = [AnchorGroup]()
}

extension BaseViewModel{
    func requestAnchorData(url:String,parameters:[String:Any]?=nil,finishedCallBack: @escaping ()->()){
        NetworkTool.requestJSON(URLString: url,parameters: parameters) { (result) in
            if let resultDict = result as? [String:Any]{
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        self.anchorGroups.append(AnchorGroup(dict: dict))
                    })
                    finishedCallBack()
                }
            }
        }
    }
    
    
}
