//
//  SettingRefreshModel.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class SettingRefreshModel: BaseModel {
    var assistSwitchInitialState:Bool = true
    /**设置开关的初始状态 当状态发生改变后 该初始状态 将会失效*/
    func setSwitchState(state:Bool)->SettingRefreshModel{
        self.assistSwitchInitialState = state
        return self
    }
}
