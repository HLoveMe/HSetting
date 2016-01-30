//
//  SettingVC2.swift
//  BaseSetting
//
//  Created by space on 16/1/30.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class SettingVC2: HSettingTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    override func loadData() {
        
       let one = SettingArrowLableModel.init(title:"Space", imageName: "stage_7", function: nil, targetClazz: resultViewController.self).setAssistText("战争学院")
        /**设置给下一个控制器传递的参数 这种方式只能针对向下传递字符串  并且 向上传递的也是该属性的值*/
        one.userInfo = ["currentTitle": one.assistTitle!]
        
        
       let two = SettingRefreshModel.init(title: "Space", imageName: "stage_0", type: .Label) { (_, view, _) -> () in
           let  lab  = view as! UILabel
           lab.text =  "正在清理"
          dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            lab.text  = "暂无数据缓存"
          }
        }.setAssistLabelText("本地缓存20M")
        
        
        let there  = SettingArrowLableModel.init(title: "Space", imageName: "stage_6", function: { (_, view, _) -> () in
            
            }, targetClazz: resultViewController2.self).setAssistText("战争学院")
        /**这种传递方式吧Model向下传递   下一控制器 必须有currentSettingModel 属性接受
            下个控制器可完全修改 model的属性  就可以改变上级Cell
        */
        
        there.isTransferSelf = true
        
        
        
        
        let group = SettingGroup.groupWithItems([one,two,there], head: nil, foot: nil)
        self.dataArray.append(group)
        
    }
    
    
}
