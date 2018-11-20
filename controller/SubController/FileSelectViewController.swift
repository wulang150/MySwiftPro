//
//  FileSelectViewController.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/7/28.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit

class FileSelectViewController: BaseController {
    
    //外部变量
    var type:Int!;
    var tableView:UITableView! = nil;
    var dataArr:[String]! = nil;            //数据源
    var dataDic:[String:String]! = nil;
    var myFile:String! = "";
    var myFile2:String! = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData();
        createView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() -> Void {
        
        //写入默认文件
        LAFileManager.writeText(toDefaultPath: "说明.txt", text: "请将测试文件放到这个目录下");
        
        dataDic = LAFileManager.getAllFile(fromDeFaultRootPath: nil, isIn: true, hasDirectory: false, containOrFilter: false, mstr: nil) as! [String : String];
        dataArr = Array(dataDic.keys);
        
        
    }

    func createView() -> Void {
        
        self.setNavWithTitle("文件选择", leftImage: "arrow", leftTitle: nil, leftAction: nil, rightImage: nil, rightTitle: nil, rightAction: nil);
        
        self.view.addSubview(self.getTableView());
        
        
        
    }
    
    func getTableView() -> UITableView {
        
        if(tableView==nil)
        {
            tableView = UITableView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
            tableView.rowHeight = 60;
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = getBottomView();
            
        }
        
        return tableView;
    }
    //获取下面的button
    func getBottomView() -> UIView {
        
        let vi:UIView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 100));
        let btn:UIButton = UIButton(type: UIButtonType.system);
        btn.frame = CGRect(x: 10, y: 30, width: SCREEN_WIDTH-20, height: 38);
        btn.setTitle("上传", for: UIControlState.normal);
        btn.layer.borderWidth = 1;
        btn.addTarget(self, action: #selector(btnAction(_:)), for: UIControlEvents.touchUpInside);
        vi.addSubview(btn);
        return vi;
    }
    
    //显示返回结果
    func showResult(retStr:String!) -> Void {
        let tv:UITextView = UITextView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-2*NavigationBar_HEIGHT));
        tv.text = retStr;
        tv.isScrollEnabled = true;
        
        let markView:CommonBgView = CommonBgView(frame: CGRect(x:0,y:0,width:SCREEN_WIDTH,height:SCREEN_HEIGHT), subView: tv);
        markView.showAnimate(CommonBgViewType.alert);
    }
    
    //btn事件
    func btnAction(_ button:UIButton) {
        
        print("btnAction");
        
        if(myFile.characters.count<=0)
        {
            
            PublicFunction.showLoading("请选择一个文件");
            return;
        }
        if(self.type==1&&myFile2.characters.count<=0)
        {
            PublicFunction.showLoading("请再选择一个文件");
            return;
        }
        
        PublicFunction.showNoHiddenLoading("处理中...");
        switch self.type {
            case 0:
                NetManager.uploadDeviceRecord(myFile, callBack: { (succ, ret) in
                    
                    PublicFunction.hiddenHUD();
                    self.showResult(retStr: ret);
                });
                break;
                
            default:
                break;
        }
    }
   
    

}

extension FileSelectViewController:UITableViewDelegate,UITableViewDataSource{
    
    //tableDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cell");
        if(cell==nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell");
        }
        //        print("height = \(tableView.rowHeight)");
        cell.textLabel?.text = dataDic[dataArr[indexPath.row]];
        cell.textLabel?.numberOfLines = 0;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let filepath:String! = dataArr[indexPath.row];
        //调用OC封装的对话框
        //        let alert:SimpleAlertView = SimpleAlertView(alertView: "文件", content: filepath, vi: nil);
        //        alert.callBack = {(str,index)->() in
        //
        //            if(index==2)
        //            {
        //                print("SimpleAlertView");
        //                if(self.myFile.characters.count<=0&&self.type==1)
        //                {
        //                    self.myFile2 = filepath;
        //                }
        //                else
        //                {
        //                    self.myFile = filepath;
        //                }
        //
        //            }
        //        };
        //
        //        alert.show();
        
        //swift的对话框
        let alert:SimpleAlertSView = SimpleAlertSView(title: "文件", content: filepath, vi: nil, btnTitle: nil);
        alert.callBack = {(str,index)->() in
            
            if(index==2)
            {
                print("SimpleAlertView");
                if(self.myFile.characters.count<=0&&self.type==1)
                {
                    self.myFile2 = filepath;
                }
                else
                {
                    self.myFile = filepath;
                }
                
            }
        };
        
        alert.show();
        
    }
}
