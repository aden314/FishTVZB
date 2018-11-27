//
//  AmuseViewModel.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/26.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class AmuseViewModel:BaseViewModel {
}

extension AmuseViewModel{
    func requestAmuseData(finishedCallBack: @escaping ()->()){
        let url = "http://capi.douyucdn.cn/api/v1/getHotRoom/2"
        requestAnchorData(url: url,finishedCallBack: finishedCallBack)
    }
}
