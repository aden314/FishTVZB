//
//  HomeViewController.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/5.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let titleViewHeight:CGFloat = 40
    
    private lazy var pageTitleView:PageTitleView = {
        let titleFrame = CGRect(x: 0, y: c_STATUS_BAR_HEIGHT+c_NAVIGATION_BAR_HEIGHT, width: c_SCREEN_WIDTH, height: titleViewHeight)
        let titles = ["推荐","娱乐","游戏","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        return titleView
    }()
    private lazy var pageContentView:PageContentView = {
        let contentViewHeight:CGFloat = c_SCREEN_HEIGHT - c_STATUS_BAR_HEIGHT - c_NAVIGATION_BAR_HEIGHT - titleViewHeight
        let contentFrame = CGRect(x: 0, y: c_STATUS_BAR_HEIGHT + c_NAVIGATION_BAR_HEIGHT + titleViewHeight, width: c_SCREEN_WIDTH, height: contentViewHeight)
        var subViewControllers = [UIViewController]()
        for _ in 0..<4{
            let viewController = UIViewController()
            viewController.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            subViewControllers.append(viewController)
        }
        let pageContentView = PageContentView(frame: contentFrame, subViewControllers: subViewControllers, parentViewController: self)
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    private func setupUI(){
        //1. 设置 NavigationBar
        setupNavigationBar()
        //2. 设置 TitleView
        view.addSubview(pageTitleView)
        //3. 设置 ContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
    }
    
    private func setupNavigationBar(){
        let size = CGSize(width: 40, height: 40)
        
        let logoButtonItem = UIBarButtonItem(imageName: "btn_logo")
        let myHistoryItem = UIBarButtonItem(imageName: "btn_my_history", highlightedImageName: "btn_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highlightedImageName: "btn_search_click", size: size)
        let scanQRCodeItem = UIBarButtonItem(imageName: "btn_scan", highlightedImageName: "btn_scan_click", size: size)
        
        navigationItem.leftBarButtonItem = logoButtonItem
        navigationItem.rightBarButtonItems = [myHistoryItem,searchItem,scanQRCodeItem]
    }
    
}
