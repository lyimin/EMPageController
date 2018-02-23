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
    @objc optional func pageController(pageController: EMPageController, titleViewAtIndex index: Int) -> UIView?
}



@objc protocol EMPageControllerDelegate {
    
}



class EMPageController: UIViewController {
    
    // MARK: ***** LifeCycle *****
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if childControllerCount <= 0 { return }
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
                return count > 0 ? count : 0
            }
            return 0
        }
    }
}


// MARK: ***** Private Methods *****
extension EMPageController {
    
    
}
