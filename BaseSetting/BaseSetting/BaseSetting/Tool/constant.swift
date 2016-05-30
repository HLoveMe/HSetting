//
//  constant.swift
//  BaseSetting
//
//  Created by space on 16/1/29.
//  Copyright © 2016年 Space. All rights reserved.
//

import UIKit

struct SectionStatus {
    /**section头的高度-----在有文字情况下*/
    var sectionHeadHeight:CGFloat = 25
    /**section头的高度-----在无文字情况下*/
    var sectionNotTextHeight:CGFloat = 15
    /**section尾的高度*/
    var sectionFootHeight:CGFloat = 20
}

struct CellStatus {
    /**设置单元格的高度*/
    var  cellHeight:CGFloat = 44
    /**cell正文字体大小*/
    var cellLabelFont:UIFont!
    var cellLabelSize:CGFloat!{
        willSet{
            if cellLabelFont.fontName  ==  UIFont.systemFontOfSize(1).fontName{
                cellLabelFont = UIFont.systemFontOfSize(newValue)
            }else{
                cellLabelFont = UIFont(name: cellLabelFont.fontName, size: newValue)
            }
        }
    }
    
    /**cell辅助字体大小*/
    var cellAssistFont:UIFont!
    var cellAssistSize:CGFloat!{
        willSet{
            if cellAssistFont.fontName  ==  UIFont.systemFontOfSize(1).fontName{
                cellAssistFont = UIFont.systemFontOfSize(newValue)
            }else{
                cellAssistFont = UIFont(name: cellAssistFont.fontName, size: newValue)
            }
            
        }
    }
    /**cell辅助文本View的最大宽度*/
    var  cellAssistLabelWidth:CGFloat = 200
    init(){
        cellLabelSize = 17
        cellLabelFont = UIFont.systemFontOfSize(17)
        
        
        cellAssistSize = 12
        cellAssistFont = UIFont.systemFontOfSize(12)
    }
    
}

