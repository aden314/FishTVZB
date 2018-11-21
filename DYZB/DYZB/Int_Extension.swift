//
//  Int_Extension.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/21.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import Foundation

extension Int{
    func changeToChineseCountString()->String{
        if self <= 10000{
            return "\(self)"
        }else{
            let tempDouble = Double(self)/10000
            return String(format: "%.2f", tempDouble) + "万"
        }
    }
}
