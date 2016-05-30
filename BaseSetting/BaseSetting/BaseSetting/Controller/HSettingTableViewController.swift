//
//  HSettingTableViewController.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class HSettingTableViewController: UITableViewController {
    var dataArray:[SettingGroup] = [SettingGroup]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(NSClassFromString("UITableViewHeaderFooterView"), forHeaderFooterViewReuseIdentifier: "HeaderFooter")
    }
    private var currentIndexPath:NSIndexPath?
    private var tempVC:UIViewController?
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath  = currentIndexPath{
            guard let vc = tempVC else{return}
            let model = dataArray[indexPath.section].itemArray![indexPath.row] as! SettingArrowModel
            if !model.isTransferSelf {
                guard let info = model.userInfo else{return}
                var gen  = info.generate()
                while let one = gen.next(){
                    model.setAssistLabelText(vc.valueForKeyPath(one.0) as! String)
                }
            }
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation:.None)
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        currentIndexPath = nil
        tempVC = nil
    }
    
    func loadData(){}
}
extension HSettingTableViewController{
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let setCell:SettingTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! SettingTableViewCell
        let group = dataArray[indexPath.section]
        let  model  = group.itemArray![indexPath.row]
        /**得到辅助视图*/
        let view = setCell.getCurrentAssistView()
        if let block = model.afunction{
            block(nil,view,setCell)
        }
        if model is SettingArrowModel {
            let currentModel = model as! SettingArrowModel
            guard let _ = currentModel.targetClazz else{return}
            let targer:UIViewController =  (currentModel.targetClazz as! UIViewController.Type).init()
            if let navi =  self.navigationController{
                navi.pushViewController(targer, animated: true)
            }else{
                self.presentViewController(UINavigationController.init(rootViewController: targer), animated: true, completion: nil)
            }
            if targer is UINavigationController{
                self.tempVC = targer.childViewControllers.last
            }else{
                self.tempVC = targer
            }
            self.currentIndexPath = indexPath
            if currentModel.isTransferSelf{
                targer.setValue(currentModel, forKey:"currentSettingModel")
            } else
            if let info = currentModel.userInfo{
                var gen =  info.generate()
                while let one = gen.next() {
                    targer.setValue(one.1, forKey: one.0)
                }
            }
        }
        
    }
}

extension HSettingTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let section = dataArray[section]
        return  section.itemArray?.count ?? 0
    }
    
    override  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell:SettingTableViewCell = SettingTableViewCell.CellWithTableView(tableView)
        let section = dataArray[indexPath.section]
        let model:BaseModel = section.itemArray![indexPath.row]
        cell.settingModel = model
        return cell
    }
    override  func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return self.dataArray.count;
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let group = self.dataArray[indexPath.section];
        let model:BaseModel = group[indexPath.row];
        return model.cellStatus.cellHeight
    }
    /**组头*/
    override func  tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let group = dataArray[section]
        if let view = group.headView{
            return view.height + 2*view.y
        }else if let _ = group.headText{
            return group.status.sectionHeadHeight
        }else{
            return group.status.sectionHeadHeight
        }
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let group = dataArray[section]
        return group.headText
    }
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HeaderFooter")
        let group = dataArray[section]
        if let color = group.headBackColor{
            headView?.contentView.backgroundColor = color
        }
        guard let view = group.headView else {return headView}
        headView?.contentView.addSubview(view)
        return headView
    }
    
    /**组尾*/
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let group = dataArray[section]
        if let view = group.footView{
            return view.height + 2*view.y
        }else if let _ = group.footText{
            return group.status.sectionFootHeight
        }else{
            return 0
        }
        
    }
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        let group = dataArray[section]
        return group.footText
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let FooterView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HeaderFooter")
        let group = dataArray[section]
        if let color = group.footBackColor{
            FooterView?.contentView.backgroundColor = color
        }
        guard let view = group.footView else {return FooterView}
        FooterView?.contentView.addSubview(view)
        return FooterView
    }
    
}