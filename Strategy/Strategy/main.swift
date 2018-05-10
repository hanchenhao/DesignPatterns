//
//  main.swift
//  Strategy
//
//  Created by 韩陈昊 on 2018/5/10.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

import Foundation

print("this is mallard duck")
let mallard = MallardDuck()
mallard.toFly()
mallard.toQuack()
print("=========")


print("this is demestic duck")
let domesticDuck = DomesticDuck()
domesticDuck.toFly()
domesticDuck.toQuack()
print("==========")


print("this is normal duck")
let duck = Duck()
duck.toFly()
duck.toQuack()
print("==========")


