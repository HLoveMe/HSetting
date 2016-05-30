//
//  ViewController.swift
//  BaseSetting
//
//  Created by space on 16/1/28.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var key = "dada"
    override func viewDidLoad() {
        super.viewDidLoad()
//        let a:CellStatus = CellStatus()
//        let aaa=0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let one = settingViewController()
        self.navigationController?.pushViewController(one, animated: true)
    }

}

