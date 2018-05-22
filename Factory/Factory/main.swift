//
//  main.swift
//  Factory
//
//  Created by 韩陈昊 on 2018/5/22.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

import Foundation


protocol Factory {
    func product() -> String
    static func make(name: String)-> Factory
}

typealias FactoryMaker = (String) -> Factory

struct ToolsFactory: Factory {
    static func make(name: String) -> Factory {
        return ToolsFactory(name: name)
    }
    private var name: String
    func product() -> String {
        return name
    }
}

struct GoodsFactory: Factory {
    static func make(name: String) -> Factory {
        return GoodsFactory(name: name)
    }
    private var name: String
    func product() -> String {
        return name
    }
}

enum FactoryType {
    case Tools, Goods
}

enum FactoryHelper {

    static func makeFor(type: FactoryType) -> FactoryMaker {
        switch type {
        case .Tools:
            return ToolsFactory.make
        case .Goods:
            return GoodsFactory.make

        }
    }
}


let tools = FactoryHelper.makeFor(type: .Tools)
let tool = tools("Screwdriver")
print(tool.product())


let goods = FactoryHelper.makeFor(type: .Goods)
let good = goods("LEGO")
print(good.product())





