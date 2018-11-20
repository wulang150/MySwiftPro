//
//  SimpleAlertSView.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/10/10.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit

class SimpleAlertSView: UIView {
    
    public var popView:UIView!;
    public var callBack:((String,Int) -> (Void))!;
    
    //内部变量
    private var alertTitle:String!;
    private var alertContent:String!;
    private var vi:UIView!;
    private var btnTitle:[String]!;
    private var iframe: CGRect!;
    private var mainView:UIView!;
    
    init(title:String,content:String,vi:UIView!,btnTitle:[String]!)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        self.alertTitle = title;
        self.alertContent = content;
        self.vi = vi;
        self.btnTitle = btnTitle;
        
        createView();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    public func show() -> Void
    {
        let window:UIWindow = UIApplication.shared.keyWindow!;
        window.addSubview(self);
    }
    
    func createView() -> Void {
        
        let view:UIView = commondView();
        //底部
        var wbtn:CGFloat = (iframe.size.width - 30)/2;
        let hbtn:CGFloat = 45;
        if(NUM(arr: btnTitle)<=0)
        {
            
            let cancleBtn:UIButton = getBtn(frame: CGRect(x: 10, y: iframe.size.height-60, width: wbtn, height: hbtn), title: "取消", tag: 1);
            let okBtn:UIButton = getBtn(frame: CGRect(x: cancleBtn.frame.maxX+10, y: cancleBtn.frame.minY, width: wbtn, height: hbtn), title: "确定", tag: 2);
            view.addSubview(cancleBtn);
            view.addSubview(okBtn);
        }
        else
        {
            if(btnTitle.count==2)
            {
                let cancleBtn:UIButton = getBtn(frame: CGRect(x: 10, y: iframe.size.height-60, width: wbtn, height: hbtn), title: btnTitle[0], tag: 1);
                let okBtn:UIButton = getBtn(frame: CGRect(x: cancleBtn.frame.maxX+10, y: cancleBtn.frame.minY, width: wbtn, height: hbtn), title: btnTitle[1], tag: 2);
                view.addSubview(cancleBtn);
                view.addSubview(okBtn);
            }
            else
            {
                wbtn = iframe.size.width - 40;
                let cancleBtn:UIButton = getBtn(frame: CGRect(x: 20, y: iframe.size.height-60, width: wbtn, height: hbtn), title: btnTitle[0], tag: 2);
                view.addSubview(cancleBtn);
            }
        }
    }
    
    func getBtn(frame:CGRect,title:String,tag:Int) -> UIButton {
        
        let btn:UIButton = UIButton(type: UIButtonType.system);
        btn.frame = frame;
        btn.setTitle(title, for: UIControlState.normal);
        btn.layer.cornerRadius = 7.0;
        btn.tag = tag;
        btn.backgroundColor = RGB(r: 236, g: 236, b: 236);
        btn.setTitleColor(UIColor.black, for: UIControlState.normal);
        btn.addTarget(self, action: #selector(buttonPressed(sender:)), for: UIControlEvents.touchUpInside);
        return btn;
    }
    
    func commondView() -> UIView {
        let width:CGFloat = 280;
        var headHeight:CGFloat = 50;
        let bottomHeight:CGFloat = 60;
        
        let bgView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
        bgView.backgroundColor = UIColor.black;
        bgView.alpha = 0.5;
        self.addSubview(bgView);
        
        if(alertTitle==nil)
        {
            headHeight = 15;
        }
        
        //中部
        let centerViewLabel:UILabel = UILabel(frame: CGRect(x: 0, y: headHeight, width: width-16, height: 40));
        centerViewLabel.textAlignment = NSTextAlignment.center;
        centerViewLabel.text = self.alertContent! as String;
        centerViewLabel.numberOfLines = 0;
        centerViewLabel.textColor = RGB(r: 128, g: 128, b: 128);
        centerViewLabel.sizeToFit();
        
        var mframe:CGRect = centerViewLabel.frame;
        mframe.size.height = mframe.size.height + 40;
        mframe.origin.x = (width - mframe.size.width)/2;
        centerViewLabel.frame = mframe;
        
        var Height:CGFloat = mframe.size.height+headHeight+bottomHeight;
        if(vi != nil)
        {
            Height = vi.frame.size.height+vi.frame.origin.y+headHeight+bottomHeight+20;
            vi.frame = CGRect(x: vi.frame.origin.x, y: vi.frame.origin.y+headHeight, width: width, height: vi.frame.size.height);
        }
        iframe = CGRect(x: (SCREEN_WIDTH-width)/2, y: (SCREEN_HEIGHT-Height)/2, width: width, height: Height);
        
        //弹出框背景
        let view:UIView = UIView(frame: iframe);
        view.backgroundColor = UIColor.white;
        view.layer.cornerRadius = 8;
        self.addSubview(view);
        mainView = view;
        
        if(vi != nil)
        {
            view.addSubview(vi);
        }
        else
        {
            view.addSubview(centerViewLabel);
        }
        
        if(alertTitle != nil)
        {
            let headLab:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: iframe.size.width, height: headHeight));
            headLab.text = alertTitle as String?;
            headLab.font = UIFont.init(name: "Arial", size: 20);
            headLab.textColor = RGB(r: 0, g: 80, b: 129);
            headLab.numberOfLines = 0;
            headLab.textAlignment = NSTextAlignment.center;
            view.addSubview(headLab);
            
        
            //下划线
            let lineView:UIView = UIView(frame: CGRect(x: 0, y: headLab.frame.maxY-1, width: iframe.size.width, height: 1));
            lineView.backgroundColor = RGB(r: 200, g: 200, b: 200);
            view.addSubview(lineView);
        }
        
        self.popView = view;
        return view;
    }
    
    func buttonPressed(sender:UIButton) -> Void {
        
        print("buttonPressed");
        if(callBack != nil)
        {
            self.callBack("",sender.tag);
        }
        
        self.removeFromSuperview();
    }

}
