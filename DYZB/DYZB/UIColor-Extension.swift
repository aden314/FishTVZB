//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/7.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
