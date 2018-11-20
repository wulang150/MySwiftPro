//
//  swiftHeader.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/7/28.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import Foundation

//获取屏幕 宽度、高度
let SCREEN_WIDTH:CGFloat = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT:CGFloat = UIScreen.main.bounds.size.height
let NavigationBar_HEIGHT:CGFloat = 64



//共同函数

func RGB(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor
{
    return UIColor(colorLiteralRed: Float(r/255.0), green: Float(g/255.0), blue: Float(b/255.0), alpha: 1);
}


func NUM(arr:[Any]!) -> Int
{
    if(arr == nil)
    {
        return 0;
    }
    else
    {
        return arr.count;
    }
}

//取CGFloat的绝对值
func fabcC(num:CGFloat) -> CGFloat {
    if (num<0)
    {
        return 0 - num;
    }
    
    return num;
}
