//
//  SettingTableViewCell.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
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
        self.textLabel?.font = UIFont.systemFontOfSize(settingModel.cellStatus.cellLabelSize)
        self.textLabel?.text  = self.settingModel.title
        self.selectionStyle = .None;
        self.accessoryView = nil
        self.currentAssistView = nil
        self.currentAssistView =  settingModel.assistView
        if (settingModel is SettingArrowModel){
            self.selectionStyle = .Blue
            let model = settingModel as! SettingArrowModel
            model.assistView?.removeFromSuperview()
            self.accessoryType = .DisclosureIndicator
            if model.type == .Label{
                let assistView:UILabel = self.settingModel.assistView as! UILabel
                self.contentView.addSubview(assistView)
                let size = assistView.text!.getSize(settingModel.cellStatus.cellAssistFont, size: CGSizeMake(settingModel.cellStatus.cellAssistLabelWidth, settingModel.cellStatus.cellAssistSize))
                assistView.frame = CGRectMake(screenWidth - size.width - 34 , 0, size.width,settingModel.cellStatus.cellHeight)
                assistView.textAlignment = .Center
                assistView.font = settingModel.cellStatus.cellAssistFont
            }else if let custom  =  model.assistView {
                let x = screenWidth - custom.width - 34
                let hei = custom.height < settingModel.cellStatus.cellHeight ? custom.height : settingModel.cellStatus.cellHeight
                let y = (settingModel.cellStatus.cellHeight  - hei)/2
                custom.frame = CGRectMake(x,y, custom.width,hei)
                self.contentView.addSubview(custom)
               
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
                let assistView:UILabel = self.settingModel.assistView as! UILabel
                self.selectionStyle = .Blue
                self.contentView.addSubview(assistView)
                self.accessoryView = assistView
                let size = assistView.text!.getSize(settingModel.cellStatus.cellAssistFont, size: CGSizeMake(settingModel.cellStatus.cellAssistLabelWidth, settingModel.cellStatus.cellAssistSize))
                assistView.frame = CGRectMake(0 , 0, size.width+10,settingModel.cellStatus.cellHeight)
                assistView.font = settingModel.cellStatus.cellAssistFont
                assistView.textAlignment = .Center
                break
            case .Custom:
                guard let custom = model.assistView else{break}
                let x = self.contentView.width - custom.width + 15
                let hei = custom.height < settingModel.cellStatus.cellHeight ? custom.height : settingModel.cellStatus.cellHeight
                let y = (settingModel.cellStatus.cellHeight - hei)/2
                custom.frame =  CGRectMake(x, y, custom.width,hei)
                self.contentView.addSubview(custom)
                self.accessoryView = custom
                break
            case .Switch:
                let customView:SettingSwitch = model.assistView! as! SettingSwitch
                customView.removeTarget(self, action: #selector(SettingTableViewCell.switchStateChange(_:)), forControlEvents: .ValueChanged)
                customView.addTarget(self, action:#selector(SettingTableViewCell.switchStateChange(_:)), forControlEvents:.ValueChanged)
                self.accessoryView = customView
                customView.mark =  self.textLabel?.text
                let flag = NSUserDefaults.getSwitchState((self.textLabel?.text)!)
                if let _ =  flag{
                    customView.setOn(flag!, animated:true)
                }else{
                    customView.setOn(model.assistSwitchInitialState, animated: true)
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