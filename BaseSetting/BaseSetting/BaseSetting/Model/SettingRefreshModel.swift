//
//  SettingRefreshModel.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit
enum AssistType:String{
    case None
    case Label
    case Switch
    case Other
}
class SettingRefreshModel: BaseModel {
    var type:AssistType
    var assistText:String?
    var assistSwitchInitialState:Bool = true
    init(title: String, imageName: String,type:AssistType, function: Block?) {
        self.type = type
        super.init(title: title, imageName: imageName, function: function)
    }
    
    /**设置自定义辅助视图*/
    func setAssistCustomView(function:()->(UIView?))->SettingRefreshModel{
        self.assistView = function()
        self.type = .Other
        return self
    }
    /**设置辅助文本文字*/
    func setAssistLabelText(text:String)->SettingRefreshModel{
        self.assistText = text
        return self
    }
    /**设置开关的初始状态 当状态发生改变后 该初始状态 将会失效*/
    func setSwitchState(state:Bool)->SettingRefreshModel{
        self.assistSwitchInitialState = state
        return self
    }
}
