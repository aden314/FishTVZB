//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/5.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(imageName:String,highlightedImageName:String = "",size:CGSize = CGSize.zero) {
        
        let btn = UIButton()
        
        if let image = UIImage(named: imageName){
            btn.setImage(image, for: .normal)
        }else{
            print("UIBarButtonItem image name error!!!")
        }
        
        if highlightedImageName != "" {
            if let image = UIImage(named: highlightedImageName){
            btn.setImage(image, for: .highlighted)
            }
        }
        
        size == CGSize.zero ? btn.sizeToFit() : (btn.frame = CGRect(origin: CGPoint.zero, size: size))
        
        self.init(customView: btn)
    }
    
}
