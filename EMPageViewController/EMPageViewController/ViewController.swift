//
//  ViewController.swift
//  EMPageViewController
//
//  Created by 梁亦明 on 2018/2/23.
//  Copyright © 2018年 com.eamon. All rights reserved.
//

import UIKit

class ViewController: EMPageController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController {
    
    func numberOfPageController(pageController: EMPageController) -> Int {
        return 10
    }
    
    func pageController(pageController: EMPageController, titleViewAtIndex index: Int) -> UIView {
        
        let itemView = EMPageItemView(frame: CGRect(x: 100, y: 100, width: 50, height: 60))
        return itemView
    }
}

