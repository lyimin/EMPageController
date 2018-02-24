//
//  EMPageItemView.swift
//  EMPageViewController
//
//  Created by 梁亦明 on 2018/2/24.
//  Copyright © 2018年 com.eamon. All rights reserved.
//

import UIKit

class EMPageItemView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(red: 0, green: 118.0/255, blue: 1, alpha: 1)
        layer.cornerRadius = 10
        
        addSubview(self.yearLabel)
        addSubview(self.monthLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yearLabel.frame = CGRect(x: 0, y: 5, width: frame.width, height: 20)
        
        monthLabel.frame = CGRect(x: 0, y: yearLabel.frame.maxY, width: frame.width, height: 30)
    }
    
    private lazy var yearLabel: UILabel = {
        
        var yearLabel = UILabel()
        yearLabel.text = "2018"
        yearLabel.textAlignment = .center
//        yearLabel.textColor = UIColor(red: 155.0/255, green: 155.0/255, blue: 155.0/255, alpha: 1)
        yearLabel.textColor = .white
        yearLabel.font = UIFont.systemFont(ofSize: 13)
        
        return yearLabel
    }()
    
    private lazy var monthLabel: UILabel = {
        
        var monthLabel = UILabel()
        monthLabel.text = "02"
        monthLabel.textAlignment = .center
//        monthLabel.textColor = UIColor(red: 20.0/255, green: 20.0/255, blue: 20.0/255, alpha: 1)
        monthLabel.textColor = .white
        monthLabel.font = UIFont.systemFont(ofSize: 28)
        
        return monthLabel
    }()
}
