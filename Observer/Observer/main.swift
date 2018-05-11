//
//  main.swift
//  Observer
//
//  Created by 韩陈昊 on 2018/5/11.
//  Copyright © 2018年 韩陈昊. All rights reserved.
//

import Foundation


//  通知
class Notification: NSObject {
    let name: String
    let object: AnyObject?
    let info: [AnyHashable: Any]?
    var count = 0
    
    init(name: String , object: AnyObject? , info: [AnyHashable: Any]?) {
        self.name = name
        self.object = object
        self.info = info
    }
    
}

//  观察者
class Observer: NSObject {
    let observer: AnyObject
    let selector: Selector
    
    init(observer: AnyObject, selector: Selector) {
        self.observer = observer
        self.selector = selector
    }
}

//  操作
class Subject: NSObject {
    var notification: Notification?
    var observers: [Observer]
    
    init(notification: Notification? , observers: [Observer] ) {
        self.notification = notification
        self.observers = observers
    }
    
    //  添加观察者
    func add(observer: Observer) -> Void {
        if observers.contains(observer) {
            return
        }
        
        observers.append(observer)
    }
    
    //  移除观察者
    func remove(observer: Observer) -> Void {
        for i in 0..<observers.count {
            if observers[i] == observer {
                observers.remove(at: i)
                break
            }
        }
    }
    
    func post() -> Void {
        
        observers.forEach { (obs) in
            
            let _  = obs.observer.perform(obs.selector, with: notification)
        }
    }
    
}

class PostCenter: NSObject {
    
    private static let singleton = PostCenter()
    static func defaultCenter() -> PostCenter {
        return singleton
    }
    
    private var center = [String: Subject]()
    
    func post(_ notification: Notification) -> Void {
        getSubject(notification).post()
    }
    
    func getSubject(_ notification: Notification) -> Subject {
        
        guard let subject = center[notification.name] else {
            center[notification.name] = Subject(notification: notification, observers: [Observer]())
            return self.getSubject(notification)
        }
        subject.notification = notification
        
        return subject
    }
    
    
    func add(observer: AnyObject , aSelector: Selector , aName: String) -> Void {
        
        var sub = center[aName]
        if sub == nil {
            sub = Subject(notification: nil, observers: [Observer]())
            center[aName] = sub
        }
        sub?.add(observer: Observer(observer: observer, selector: aSelector))
        
    }
    
    func remove(observer: AnyObject , name: String) -> Void {
        guard let subject = center[name] else {
            return
        }
        subject.remove(observer: observer as! Observer)
    }
    
    override private init() {
        super.init()
    }
    
    
}


class PostOffice: NSObject {
    func send(message: AnyObject) -> Void {
        
        PostCenter.defaultCenter().post(Notification(name: "PostMessage", object: self, info: ["info": message] ))
        
    }
}


class User: NSObject {
    
    func subscription() -> Void {
        PostCenter.defaultCenter().add(observer: self, aSelector: #selector(User.incept(_:)), aName: "PostMessage")
    }
    
    @objc func incept(_ message: Notification) -> Void {
        guard let msg = message.info else {
            print("no message")
            return
        }
        print(msg)
    }
    
    deinit {
        PostCenter.defaultCenter().remove(observer: self, name: "PostMessage")
    }
}


let postman = PostOffice()

let user1 = User()
let user2 = User()
let user3 = User()

user1.subscription()
user2.subscription()

postman.send(message: "post 1" as AnyObject)
postman.send(message: "post 2" as AnyObject)
postman.send(message: "post 3" as AnyObject)





