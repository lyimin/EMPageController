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
    /// 结合preferredFrameForMenuView方法一起使用
    @objc optional func pageController(pageController: EMPageController, titleViewAtIndex index: Int) -> UIView
    
    /// 返回菜单View的Frame
    @objc optional func pageController(pageController: EMPageController, preferredFrameForMenuView: EMMenuView) -> CGRect
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
        calculateSize()
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
            
            if responds(to: #selector(EMPageControllerDataSource.numberOfPageController(pageController:))) {
                
                let count = dataSource!.numberOfPageController!(pageController: self)
                return max(0, count)
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
        return childControllerCount
    }
    
    func menuView(menuView: EMMenuView, titleViewAtIndex index: Int) -> UIView? {
        return titleViewAtIndex(index: index)
    }
}


// MARK: ***** Private Methods *****
extension EMPageController {
    
    private func initView() {
        
        view.addSubview(self.menuView)
    }
    
    private func calculateSize() {
        
        // menuView
        if responds(to: #selector(EMPageControllerDataSource.pageController(pageController:preferredFrameForMenuView:))) {
            
            let menuViewFrame = dataSource!.pageController!(pageController: self, preferredFrameForMenuView: menuView)
            if menuViewFrame != CGRect.zero {
                menuView.frame = menuViewFrame
            } else {
                menuView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
            }
        }
    }
    
    private func titleViewAtIndex(index: Int) -> UIView? {
        
        if responds(to: #selector(EMPageControllerDataSource.pageController(pageController:titleViewAtIndex:))) {
            let itemView = dataSource!.pageController?(pageController: self, titleViewAtIndex: index)
            return itemView
        }
        
        return nil
    }
}
