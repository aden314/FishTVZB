//
//  PageTitleView.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/6.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate:class {
    func titleIndexChanged(withTitleViwe:PageTitleView,currentIndex index:Int)
}

class PageTitleView: UIView {
    
    let c_SCROLL_LINE_HEIGHT:CGFloat = 2
    let c_NORMAL_TITLE_COLOR:(CGFloat,CGFloat,CGFloat) = (85,85,85)
    let c_SELECT_TITLE_COLOR:(CGFloat,CGFloat,CGFloat) = (255,128,0)
    
    private var titles:[String]
    weak var delegate:PageTitleViewDelegate?
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
    private var currentLabelIndex:Int = 0

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
            
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tabGesture:)))
            label.addGestureRecognizer(tapGesture)
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
        firstLabel.textColor = UIColor(RGBColorGourp: c_SELECT_TITLE_COLOR)
        scrollLine.frame = CGRect(x: firstLabel.frame.minX, y: firstLabel.frame.height - c_SCROLL_LINE_HEIGHT, width: firstLabel.frame.width, height: c_SCROLL_LINE_HEIGHT)
    }
    
    @objc private func titleLabelClick(tabGesture: UITapGestureRecognizer){
        guard let currentLabel = tabGesture.view as? UILabel else {return}
        if currentLabel.tag == currentLabelIndex {return}
        let oldLabel = titleLabels[currentLabelIndex]
        currentLabel.textColor = UIColor(RGBColorGourp: c_SELECT_TITLE_COLOR)
        oldLabel.textColor = UIColor(RGBColorGourp: c_NORMAL_TITLE_COLOR)
        currentLabelIndex = currentLabel.tag
        
        //scrollLine.frame = CGRect(x: currentLabel.frame.minX, y: currentLabel.frame.height - c_SCROLL_LINE_HEIGHT, width: currentLabel.frame.width, height: c_SCROLL_LINE_HEIGHT)
        
        let scrollLineX:CGFloat = CGFloat(currentLabelIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.titleIndexChanged(withTitleViwe: self, currentIndex: currentLabelIndex)
        
    }
    
    func setCurrentTitleIndex(_ progress:CGFloat, _ sourceIndex:Int, _ targetIndex:Int){
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let totalMoveX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = totalMoveX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        let colorVariation = (c_SELECT_TITLE_COLOR - c_NORMAL_TITLE_COLOR) * progress
        
        sourceLabel.textColor = UIColor(RGBColorGourp: c_SELECT_TITLE_COLOR - colorVariation)
        targetLabel.textColor = UIColor(RGBColorGourp: c_NORMAL_TITLE_COLOR + colorVariation)
        
        currentLabelIndex = targetIndex
    }
    
}
