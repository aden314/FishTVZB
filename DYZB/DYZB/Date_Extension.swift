//
//  Date_Extension.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import Foundation

extension Date{
    static func currentTime()->String{
        return "\(Date.timeIntervalBetween1970AndReferenceDate)"
    }
}
