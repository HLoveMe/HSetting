//
//  settingViewController.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit
func  randomColor() ->UIColor {
    let red = Float(arc4random_uniform(256)) / 255.0
    let green = Float(arc4random_uniform(256)) / 255.0
    let blue = Float(arc4random_uniform(256)) / 255.0
    return UIColor.init(colorLiteralRed: red, green: green, blue: blue, alpha: 1.0)
}
class settingViewController: HSettingTableViewController {
    /**重写*/
    override func loadData() {
//        SettingArrowLableModel  点击跳转到下界面

        /**自定义辅助视图*/
        let one  = SettingArrowLableModel.init(title: "青铜", imageName: "stage_0", function: nil, targetClazz:UIViewController.self).setAssistCustomView { () -> (UIView) in
           let one = UISegmentedControl.init(items: ["One","Two"])
            one.frame = CGRectMake(0, 0, 100,40)
            one.selectedSegmentIndex = 1
           return one
        }
        one.setfunction { (_, view, _) -> () in
           let index = (view as! UISegmentedControl).selectedSegmentIndex
           let title = (view as! UISegmentedControl).titleForSegmentAtIndex(index)
            print("\(title)")
        }
        
        /**传入文本 使用Label*/
        let two  = SettingArrowLableModel.init(title: "白银", imageName: "stage_1", function: { (_,view,_) -> () in
            let lab = view as! UILabel
                print("\(lab.text)")
            }, targetClazz: UIViewController.self).setAssistText("我的段位")
        
        
        /**在现有基础上对 cell进行其他操作*/
        let twoThere = SettingArrowLableModel.init(title: "黄金", imageName: "stage_2", function: nil, targetClazz: UIViewController.self).setAssistCustomView { () -> (UIView) in
            let one  = UIButton.init(frame: CGRectMake(0, 5, 100, 70))
            one.setTitle("自定义按钮", forState:.Normal)
            one.backgroundColor = UIColor.orangeColor()
            one.addTarget(self, action: "click", forControlEvents: .TouchUpInside)
            return one
        }.setOperationCell { (cell) -> () in
              cell.contentView.backgroundColor = randomColor()
        }
        
        
        /**创建一组*/
        let group0 = SettingGroup.groupWithItems([one,two,twoThere], head:"第一组头", foot:nil)
        
        
        
        
        
//       SettingRefreshModel 点击不会跳转
        
        /**没有任何辅助视图*/
        let none =  SettingRefreshModel.init(title: "铂金", imageName: "stage_3", type: AssistType.None, function: nil)
        
        /**switch作为辅助视图*/
        let there = SettingRefreshModel.init(title: "砖石", imageName: "stage_4", type: AssistType.Switch, function: nil).setSwitchState(true)
        
        /**label作为辅助视图*/
        let four = SettingRefreshModel.init(title: "大师", imageName: "stage_5", type: AssistType.Label, function:  { (_,view,_) -> () in
            let lab = view as! UILabel
            print("\(lab.text)")
        }).setAssistLabelText("深圳")
      
        /**自定义辅助视图*/
        let other = SettingRefreshModel.init(title: "最强王者", imageName: "stage_6", type: AssistType.Other, function:  { (_,view,_) -> () in
            let act = view as! UIActivityIndicatorView
            if act.isAnimating() {
                act.stopAnimating()
            }else{
                act.startAnimating()
            }
        }).setAssistCustomView { () -> (UIView?) in
           let one = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
            one.startAnimating()
            return one
        }
        
        /**第二组  并设置尾部视图*/
        let  group1 = SettingGroup.groupWithItems([none,there,four,other], head: nil, foot:nil).setFooterView { () -> (UIView?) in
            let imageV =  UIImageView.init(frame: CGRectMake(100,10, 200, 50))
            imageV.image = UIImage.init(named: "test")
            return imageV
        }
        group1.footBackColor = UIColor.yellowColor()
        
        /**测试*/
        let 我 = SettingArrowLableModel.init(title: "怎么往下传值  往上传值刷新UI", imageName: "", function: nil, targetClazz: SettingVC2.self)
        let 组 = SettingGroup.groupWithItems([我], head: nil, foot: nil)
        
        dataArray.append(group0)
        dataArray.append(group1)
        dataArray.append(组)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    /**创建数据 调用*/
        loadData()
    }
    func click(){
        print("\("点击自定义按钮")")
    }
    
}
