//
//  GameViewModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/25.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class GameViewModel{
    lazy var gameModels:[GameModel] = [GameModel]()
}

extension GameViewModel{
    func requestAllGameData(finishedCallBack: @escaping ()->()){
        let url = "http://capi.douyucdn.cn/api/v1/getColumnDetail"
        //let parameters = ["shortName":"game"]
        
        NetworkTool.requestJSON(URLString: url) { (result) in
            if let resultDict = result as? [String:Any]{
                if let dataArray = resultDict["data"] as? [[String:Any]]{
                    dataArray.forEach({ (dict) in
                        self.gameModels.append(GameModel(dict: dict))
                    })
                    finishedCallBack()
                }
            }
        }
    }
}
