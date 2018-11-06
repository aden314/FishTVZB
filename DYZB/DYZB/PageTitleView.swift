//
//  PageTitleView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/6.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    let c_SCROLL_LINE_HEIGHT:CGFloat = 2
    
    private var titles:[String]
    private lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    private lazy var scrollLine:UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    private lazy var titleLabels:[UILabel] = [UILabel]()

    init(frame: CGRect,titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        self.addSubview(scrollView)
        scrollView.frame = self.bounds
        setupTitleLabels()
        setupBottomLineAndScrollLine()
    }
    
    private func setupTitleLabels(){
        let labelWidth:CGFloat = self.frame.width / CGFloat(titles.count)
        let labelHeight:CGFloat = self.frame.height - c_SCROLL_LINE_HEIGHT
        
        let labelY:CGFloat = 0
        
        
        for (index,title) in titles.enumerated(){
            let label = UILabel()
            
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            
            let labelX:CGFloat = labelWidth * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            titleLabels.append(label)
            scrollView.addSubview(label)
        }
    }
    
    private func setupBottomLineAndScrollLine(){
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let bottomLineHeight:CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: self.frame.height - bottomLineHeight , width: self.frame.width, height: bottomLineHeight)
        self.addSubview(bottomLine)
        
        scrollView.addSubview(scrollLine)
        guard let firstLabel = titleLabels.first else {return}
        firstLabel.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.minX, y: firstLabel.frame.height - c_SCROLL_LINE_HEIGHT, width: firstLabel.frame.width, height: c_SCROLL_LINE_HEIGHT)
    }
    
}
