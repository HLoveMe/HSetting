//
//  SettingArrowLableModel.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class SettingArrowLableModel: BaseModel {
/**辅助Lable文字*/
    var assistTitle:String?
/**下一界面的Class*/
    var targetClazz:AnyClass?
/**在界面跳转后给下一个界面的参数*/
    var userInfo:[String:String]?
/**表示是否把本Model传递到下一控制器*/
    var isTransferSelf:Bool = false {
        didSet{
            userInfo = nil
        }
    }
    init(title: String, imageName: String, function: Block?,targetClazz:AnyClass?) {
        self.targetClazz = targetClazz
        super.init(title: title, imageName: imageName, function: function)
    }
    /**设置辅助文本*/
    func   setAssistText(text:String)->SettingArrowLableModel{
        self.assistTitle = text
        return self
    }
    /**设置辅助UIView*/
    func setAssistCustomView(function:()->(UIView?))->SettingArrowLableModel{
        self.assistView = function()
        return self
    }
}
