//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/7.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

extension UIColor{
    
    open class var randomColor:UIColor{
        get{
            return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        }
    }
    
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    
    convenience init(RGBColorGourp:(CGFloat,CGFloat,CGFloat)) {
        self.init(red: RGBColorGourp.0/255.0, green: RGBColorGourp.1/255.0, blue: RGBColorGourp.2/255.0, alpha: 1.0)
    }
    
    class func getRandomColor()->UIColor{
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
    
}
