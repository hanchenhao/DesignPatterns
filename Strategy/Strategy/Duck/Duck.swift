//
//  Duck.swift
//  Strategy
//
//  Created by 韩陈昊 on 2018/5/10.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

import Cocoa

class Duck: NSObject {
    
    internal var flyBehavior: FlyBehavior = FlyWay()
    internal var quackBehavior: QuackBehavior = GuQuack()

    func toFly() -> Void {
        flyBehavior.fly()
    }
    
    func toQuack() -> Void {
        quackBehavior.quack()
    }
}
