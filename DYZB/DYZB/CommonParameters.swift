//
//  CommonParameters.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/6.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

// UIScreen Main Frame Size
let c_SCREEN_WIDTH = UIScreen.main.bounds.width
let c_SCREEN_HEIGHT = UIScreen.main.bounds.height

// Status bar height
let c_STATUS_BAR_HEIGHT:CGFloat = 20

// Navigation bar height
let c_NAVIGATION_BAR_HEIGHT:CGFloat = 44

// Betwin two (CGFloat,CGFloat,CGFloat) operation
func +(left:(CGFloat,CGFloat,CGFloat),right:(CGFloat,CGFloat,CGFloat)) -> (CGFloat,CGFloat,CGFloat){
    return (left.0 + right.0,left.1 + right.1,left.2 + right.2)
}

func -(left:(CGFloat,CGFloat,CGFloat),right:(CGFloat,CGFloat,CGFloat)) -> (CGFloat,CGFloat,CGFloat){
    return (left.0 - right.0,left.1 - right.1,left.2 - right.2)
}

func *(left:(CGFloat,CGFloat,CGFloat),right:(CGFloat,CGFloat,CGFloat)) -> (CGFloat,CGFloat,CGFloat){
    return (left.0 * right.0,left.1 * right.1,left.2 * right.2)
}
func /(left:(CGFloat,CGFloat,CGFloat),right:(CGFloat,CGFloat,CGFloat)) -> (CGFloat,CGFloat,CGFloat){
    return (left.0 / right.0,left.1 / right.1,left.2 / right.2)
}

// Betwin (CGFloat,CGFloat,CGFloat) & CGFloat operation
func +(left:(CGFloat,CGFloat,CGFloat),right:CGFloat) -> (CGFloat,CGFloat,CGFloat) {
    return (left.0 + right,left.1 + right,left.2 + right)
}

func -(left:(CGFloat,CGFloat,CGFloat),right:CGFloat) -> (CGFloat,CGFloat,CGFloat) {
    return (left.0 - right,left.1 - right,left.2 - right)
}


func *(left:(CGFloat,CGFloat,CGFloat),right:CGFloat) -> (CGFloat,CGFloat,CGFloat) {
    return (left.0 * right,left.1 * right,left.2 * right)
}

func /(left:(CGFloat,CGFloat,CGFloat),right:CGFloat) -> (CGFloat,CGFloat,CGFloat) {
    return (left.0 / right,left.1 / right,left.2 / right)
}
