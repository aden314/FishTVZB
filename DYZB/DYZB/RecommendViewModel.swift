//
//  RecommendViewModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class RecommendViewModel:BaseViewModel{
    lazy var cycleModels:[CycleModel] = [CycleModel]()
    private lazy var bigDataGroup = AnchorGroup(tagName: "热门", iconName: "home_header_hot")
    private lazy var prettyGroup = AnchorGroup(tagName: "颜值", iconName: "home_header_phone")
}

// 网络请求

extension RecommendViewModel{
    
    func requestData(finishedCallBack: @escaping ()->()){
        let hotCateURL = "http://capi.douyucdn.cn/api/v1/getHotCate"
        let verticalRoomURL = "http://capi.douyucdn.cn/api/v1/getVerticalRoom"
        let bigDataRoomURL = "http://capi.douyucdn.cn/api/v1/getBigDataRoom"
        let patameters = ["limit":"4","offset":"0"]
        
        let dispatchGroup = DispatchGroup()
        
        //1. 请求0推荐内容
        dispatchGroup.enter()
        NetworkTool.requestJSON(URLString:bigDataRoomURL) { (result) in
            if let resultDict = result as? [String:Any] {
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        let anchor = AnchorModel(dict: dict)
                        self.bigDataGroup.anchors.append(anchor)
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
                        self.prettyGroup.anchors.append(anchor)
                    })
                }
            }
            dispatchGroup.leave()
        }
        
        //3. 请求2-12游戏内容
        dispatchGroup.enter()
        requestAnchorData(url: hotCateURL,parameters: patameters) {
            dispatchGroup.leave()
        }
//        NetworkTool.requestJSON(URLString:hotCateURL,parameters: patameters) { (result) in
//            if let resultDict = result as? [String:Any] {
//                if let dataArray = resultDict["data"] as? [[String:Any]]{
//                    dataArray.forEach({ (dict) in
//                        let group = AnchorGroup(dict: dict)
//                        self.anchorGroups.append(group)
//                    })
//                }
//            }
//            dispatchGroup.leave()
//        }
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishedCallBack()
        }
    }
    
    func requestCycleViewData(finishedCallBack:@escaping ()->()){
        let slideURL = "http://capi.douyucdn.cn/api/v1/slide/6"
        let parameters = ["version":"2.300"]
        
        NetworkTool.requestJSON(URLString: slideURL,method:HTTPMethodType.get,  parameters: parameters) { (result) in
            if let resultDict = result as? [String:Any]{
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        self.cycleModels.append(CycleModel(dict: dict))
                    })
                     finishedCallBack()
                }
            }
        }
        
    }
    
    
   
}
