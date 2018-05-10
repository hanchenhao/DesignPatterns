//
//  DomesticDuck.swift
//  Strategy
//
//  Created by 韩陈昊 on 2018/5/10.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

import Cocoa

class DomesticDuck: Duck {
    override init() {
        super.init()
        flyBehavior = FlyNoWay()
        quackBehavior = GuQuack()
    }

}
