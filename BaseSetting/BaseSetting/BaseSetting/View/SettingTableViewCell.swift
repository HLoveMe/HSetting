//
//  SettingTableViewCell.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    lazy var lable:UILabel =  {
        let one = UILabel.init(frame: CGRectZero)
        return one
    }()
    lazy var Hswitch:SettingSwitch = {
        var one =  SettingSwitch()
        one.addTarget(self, action:"switchStateChange:", forControlEvents:.ValueChanged)
        return one
    }()
    let  screenWidth:CGFloat = UIScreen.mainScreen().bounds.width
    private var currentAssistView:UIView?
    var settingModel:BaseModel!{
        didSet{
            self.loadSubViews()
        }
    }
    
    
    func loadSubViews(){
        (self.contentView.subviews as NSArray).enumerateObjectsUsingBlock { (View, _, _) -> Void in
            View.removeFromSuperview()
        }
        self.imageView?.image = UIImage.init(named: self.settingModel.imageName)
        self.textLabel?.font = cellLabelFont
        self.textLabel?.text  = self.settingModel.title
        self.selectionStyle = .None;
        self.accessoryView = nil
        self.currentAssistView = nil
        if (settingModel is SettingArrowLableModel){
            self.selectionStyle = .Blue
            let model = settingModel as! SettingArrowLableModel
            model.assistView?.removeFromSuperview()
            self.accessoryType = .DisclosureIndicator
            if let title = model.assistTitle{
                self.contentView.addSubview(self.lable)
                self.currentAssistView =  self.lable
                let size = title.getSize(cellAssistFont, size: CGSizeMake(cellAssistLabelWidth, cellAssistSize))
                self.lable.frame = CGRectMake(screenWidth - size.width - 34 , 0, size.width, self.height)
                self.lable.textAlignment = .Center
                self.lable.font = cellAssistFont
                self.lable.text = title
            }else if let custom  =  model.assistView {
                let x = screenWidth - custom.width - 34
                let hei = custom.height < cellHeight ? custom.height : cellHeight
                let y = (cellHeight - hei)/2
                custom.frame = CGRectMake(x,y, custom.width,hei)
                self.contentView.addSubview(custom)
                self.currentAssistView =  custom
            }
        }else if(settingModel is SettingRefreshModel){
            self.accessoryType = .None
            let model = settingModel as! SettingRefreshModel
            model.assistView?.removeFromSuperview()
            switch model.type{
            case .None:
                self.selectionStyle = .Blue
                break
            case .Label:
                self.selectionStyle = .Blue
                self.contentView.addSubview(self.lable)
                self.currentAssistView =  self.lable
                self.accessoryView = self.lable
                guard let _ = model.assistText else{break}
                let size = model.assistText!.getSize(cellAssistFont, size: CGSizeMake(cellAssistLabelWidth, cellAssistSize))
                self.lable.frame = CGRectMake(0 , 0, size.width+10, self.height)
                self.lable.font = cellAssistFont
                self.lable.textAlignment = .Center
                self.lable.text = model.assistText ?? ""
                break
            case .Other:
                guard let custom = model.assistView else{break}
                if (custom.isKindOfClass(NSClassFromString("UIControl")!)){
                    self.selectionStyle = .None
                }else{
                    self.selectionStyle = .Blue
                }
                let x = self.contentView.width - custom.width + 15
                custom.frame =  CGRectMake(x, 0, custom.width, cellHeight)
                self.contentView.addSubview(custom)
                self.currentAssistView = custom
                self.accessoryView = custom
                break
            case .Switch:
                self.accessoryView = self.Hswitch
                self.currentAssistView = self.Hswitch
                self.Hswitch.mark =  self.textLabel?.text
                let flag = NSUserDefaults.getSwitchState((self.textLabel?.text)!)
                if let _ =  flag{
                    self.Hswitch.setOn(flag!, animated:true)
                }else{
                    self.Hswitch.setOn(model.assistSwitchInitialState, animated: true)
                }
                break
            }
        }
        guard let _ = self.settingModel.operationBlock else{return}
        self.settingModel.operationBlock!(self)
    }
}
extension SettingTableViewCell{
    class func CellWithTableView(tableView:UITableView)->SettingTableViewCell{
        let ID:String = "ID"
        var cell:SettingTableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID) as? SettingTableViewCell
        if cell == nil {
            cell = SettingTableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
        }
        return cell!
    }
}
extension SettingTableViewCell{
    func switchStateChange(swith:SettingSwitch){
        guard let _ = swith.mark else {return}
        NSUserDefaults.saveSwitchState(swith.mark!, state: swith.on)
    }
    func getCurrentAssistView()->UIView?{
        return self.currentAssistView
    }
}

extension UIView{
    /**width*/
    var width:CGFloat {
        get{
            return  self.bounds.size.width
        }
        set{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newValue, self.frame.size.height)
        }
    }
    /**height*/
    var height:CGFloat {
        get{
            return  self.bounds.size.height
        }
        set{
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,self.frame.size.width,newValue)
        }
    }
    var y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var rect:CGRect = self.frame
            rect.origin = CGPointMake(rect.origin.x,newValue)
            self.frame = rect
        }
    }
}
extension String{
    func getSize(font:UIFont,size:CGSize)->CGSize{
        let  str:NSString = self as NSString
        return str.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size
    }
}
extension NSUserDefaults{
    /**得到switch状态*/
    class  func getSwitchState(title:String)->Bool?{
        return  NSUserDefaults.standardUserDefaults().objectForKey(title)?.boolValue
    }
    /**保存开关状态*/
    class func saveSwitchState(title:String,state:Bool){
        NSUserDefaults.standardUserDefaults().setBool(state, forKey: title)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}