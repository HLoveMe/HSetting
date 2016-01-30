//
//  SettingGroup.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit
class SettingGroup{
    var itemArray:[BaseModel]?
    var footBackColor:UIColor?
    var footText:String?
    var footView:UIView?
    
    var headBackColor:UIColor?
    var headText:String?
    var headView:UIView?
    
    
    static func group() ->SettingGroup{
        return SettingGroup.init()
    }
    static func groupWithItems(items:[BaseModel],head:String?,foot:String?)->SettingGroup{
        let group = SettingGroup.init()
        group.itemArray = items
        group.headText = head
        group.footText = foot
        return group
    }
    /**设置组尾视图*/
     func setFooterView(option:()->(UIView?))->SettingGroup{
        self.footView = option()
        return self
    }
    /**设置组头视图*/
     func setHeadView(option:()->(UIView?))->SettingGroup{
        self.headView = option()
        return self
    }
}
