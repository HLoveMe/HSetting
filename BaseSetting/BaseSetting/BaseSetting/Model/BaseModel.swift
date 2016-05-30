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
enum AssistType:String{
    case None
    case Label
    case Switch
    case Custom
}
class BaseModel: NSObject,SettingType{
    typealias Block = (AnyObject?,UIView?,SettingTableViewCell)->()
    typealias operation = (SettingTableViewCell)->()
    /**主题*/
    var title:String = ""
    /**图片名*/
    var imageName:String = ""
    /**点击cell附带的代码*/
    var afunction:Block?
    /**在原有基础之上对Cell特别的操作 在布局之后调用*/
    var operationBlock:operation?
    
    var type:AssistType = .None
    /**辅助视图*/
    var assistView:UIView?
    /**全局设置*/
    var cellStatus:CellStatus = CellStatus()
    
    var height:CGFloat{
        set{
            self.cellStatus.cellHeight = newValue
        }
        get{
            return self.cellStatus.cellHeight
        }
    }
    private override init() {}
    init(title:String,imageName:String,assistType:AssistType = .None,function:Block?) {
        super.init()
        self.title = title
        self.type=assistType
        self.imageName = imageName
        self.afunction = function
        self.createSubview()
    }
    
    init(title:String,imageName:String,assistType:AssistType = .None) {
        super.init()
        self.title = title
        self.imageName = imageName
        self.type=assistType
        createSubview()
    }
    func createSubview(){
        switch type {
        case .Label:
            let label:UILabel  = UILabel.init()
            label.text=""
            self.assistView = label
            break
        case .Switch:
            self.assistView = SettingSwitch()
            break
        case .Custom:
            break
        default:
            break
        }
        
    }
    /**设置辅助文本文字*/
    func setAssistLabelText(text:String)->Self{
        if self.assistView is UILabel {
            (self.assistView as! UILabel).text=text
        }
        return self
    }
     /**设置自定义辅助视图*/
    func setAssistCustomView(function:()->(UIView?))->Self{
        self.assistView = function()
        self.type = .Custom
        return self
    }
    func setfunction(function:Block?){
        self.afunction = function
    }
    /**对cell进行另外的操作 在布局后调用*/
    func setOperationCell(function:operation)->BaseModel{
        self.operationBlock = function
        return self
    }
}