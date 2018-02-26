//
//  EMPageController.swift
//  EMPageViewController
//
//  Created by 梁亦明 on 2018/2/23.
//  Copyright © 2018年 com.eamon. All rights reserved.
//

import Foundation
import UIKit

@objc protocol EMPageControllerDataSource {
    
    /// 返回控制器的数量
    @objc optional func numberOfPageController(pageController: EMPageController) -> Int
    
    /// 返回Index对应的控制器
    @objc optional func pageController(pageController: EMPageController, atIndex index: Int) -> UIViewController?
    
    /// 返回控制器对应的标题
    @objc optional func pageController(pageController: EMPageController, titleAtIndex index: Int) -> String?
    
    /// 返回控制器对应的自定义标题view
    @objc optional func pageController(pageController: EMPageController, titleViewAtIndex index: Int) -> UIView
}

@objc protocol EMPageControllerDelegate {
    
}



class EMPageController: UIViewController, EMPageControllerDataSource, EMPageControllerDelegate {
    
    // MARK: ***** LifeCycle *****
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dataSource = self
        delegate = self
        
        if childControllerCount <= 0 { return }
        
        initView()
    }
    
    // MARK: ***** Public Property *****
    
    // 数据源
    public weak var dataSource: EMPageControllerDataSource?
    
    // 代理
    public weak var delegate: EMPageControllerDelegate?
    
    // 控制器标题
    public var titles: Array<String>?
    
    // 自定义控制器标题
    public var titleViews: Array<UIView>?
    
    // 控制器
    public var controllers: Array<UIViewController>?
    
    // MARK: ***** Private Property *****
    
    // 控制器的数量
    private var childControllerCount: Int {
        get {
            guard dataSource != nil else { return 0 }
            
            if responds(to: Selector(("numberOfPageController:"))) {
                
                let count = dataSource!.numberOfPageController!(pageController: self)
                return max(0, count)
//                return count > 0 ? count : 0
            }
            return 0
        }
    }
    
    private lazy var menuView: EMMenuView = {
        
        var menuView = EMMenuView()
        menuView.dataSource = self
        return menuView
    }()
}

// MARK: ***** EMMenuViewDelegate | EMMenuViewDataSource *****
extension EMPageController: EMMenuViewDataSource {
    
    
    func numberOfTitlesInMenuView(menuView: EMMenuView) -> Int {
        return 0
    }
    
    func menuView(menuView: EMMenuView, titleViewAtIndex index: Int) -> UIView? {
        return titleViewAtIndex(index: index)
    }
    
}


// MARK: ***** Private Methods *****
extension EMPageController {
    
    private func initView() {
        
    }
    
    private func titleViewAtIndex(index: Int) -> UIView? {
        
        guard dataSource != nil else { return nil }
        
        if responds(to: Selector(("pageController:"))) {
            let itemView = dataSource!.pageController?(pageController: self, titleViewAtIndex: index)
            return itemView
        }
        
        return nil
    }
}
