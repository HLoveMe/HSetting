//
//  BaseModel.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit
protocol SettingType:NSObjectProtocol{
    var title:String{get set}
    var imageName:String{get set}
}
class BaseModel: NSObject,SettingType{
    typealias Block = (AnyObject?,UIView?,SettingTableViewCell)->()
    typealias operation = (SettingTableViewCell)->()
/**主题*/
    var title:String = ""
/**图片名*/
    var imageName:String = ""
/**点击cell附带的代码*/
    var function:Block?
/**在原有基础之上对Cell特别的操作*/
    var operationBlock:operation?
/**辅助视图*/
    var assistView:UIView?
    private override init() {}
    init(title:String,imageName:String,function:Block?) {
        self.title = title
        self.imageName = imageName
        self.function = function
    }
    init(title:String,imageName:String) {
        self.title = title
        self.imageName = imageName
    }
    func setfunction(function:Block?){
        self.function = function
    }
    /**对cell进行另外的操作*/
    func setOperationCell(function:operation)->BaseModel{
        self.operationBlock = function
        return self
    }
}