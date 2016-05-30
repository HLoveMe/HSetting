//
//  resultViewController2.swift
//  BaseSetting
//
//  Created by space on 16/1/30.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class resultViewController2: UIViewController {
    
    /**必须有 currentSettingModel 该属性*/
    var currentSettingModel:SettingArrowModel?
    
    lazy  var tableView:UITableView = {
        var tableView = UITableView.init(frame: self.view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    var dataArray:[String] = {
        let one = ["艾欧尼亚","诺克萨斯","班德尔城","皮尔特沃夫","战争学院","巨神峰","雷瑟守备","教育网专区"]
        return one
    }()
    var currentCell:UITableViewCell?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
       
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
 /**测试    修改Model的属性*/
        currentSettingModel?.setOperationCell({ (cell) -> () in
            cell.getCurrentAssistView()?.backgroundColor = randomColor()
        })
    }
}
extension resultViewController2:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return  self.dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ID:String = "ID"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(ID)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: ID)
        }
        cell?.textLabel?.text = self.dataArray[indexPath.row]
        cell?.accessoryType = .None
        let custom:UILabel =  self.currentSettingModel?.assistView as! UILabel
        if (self.dataArray[indexPath.row] == custom.text){
            cell?.accessoryType = .Checkmark
            self.currentCell = cell
        }
        return cell!
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.currentSettingModel?.setAssistLabelText(self.dataArray[indexPath.row])
        self.currentCell?.accessoryType = .None
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        self.currentCell =  tableView.cellForRowAtIndexPath(indexPath)
    }
}
