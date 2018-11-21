//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class RecommendViewModel{
    
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    
}

// 网络请求

extension RecommendViewModel{
    
    func requestData(finishedCallBack: @escaping ()->()){
        let hotCateURL = "http://capi.douyucdn.cn/api/v1/getHotCate"
        let verticalRoomURL = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        let bigDataRoomURL = "http://capi.douyucdn.cn/api/v1/getBigDataRoom"
        let patameters = ["limit":"4","offset":"0"]
        
        let bigDataGroup = AnchorGroup(tagName: "热门", iconName: "home_header_hot")
        let prettyGroup = AnchorGroup(tagName: "颜值", iconName: "home_header_phone")
        
        let dispatchGroup = DispatchGroup()
        
        
        //1. 请求0推荐内容
        dispatchGroup.enter()
        NetworkTool.requestJSON(URLString:bigDataRoomURL) { (result) in
            if let resultDict = result as? [String:Any] {
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        let anchor = AnchorModel(dict: dict)
                        bigDataGroup.anchors.append(anchor)
                    })
                }
            }
            dispatchGroup.leave()
        }
        
        //2. 请求1颜值内容
        dispatchGroup.enter()
        NetworkTool.requestJSON(URLString:verticalRoomURL,parameters: patameters) { (result) in
            if let resultDict = result as? [String:Any] {
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        let anchor = AnchorModel(dict: dict)
                        prettyGroup.anchors.append(anchor)
                    })
                }
            }
            dispatchGroup.leave()
        }
        
        //3. 请求2-12游戏内容
        dispatchGroup.enter()
        NetworkTool.requestJSON(URLString:hotCateURL,parameters: patameters) { (result) in
            if let resultDict = result as? [String:Any] {
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        let group = AnchorGroup(dict:dict)
                        self.anchorGroups.append(group)
                    })
                }
            }
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(prettyGroup, at: 0)
            self.anchorGroups.insert(bigDataGroup, at: 0)
            finishedCallBack()
        }
    }
   
}
