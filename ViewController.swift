//
//  ViewController.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/7/27.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit
import Foundation

class ViewController: BaseController ,UITableViewDelegate,UITableViewDataSource,BottomSelectViewDelegate{
    
    var tableView:UITableView! = nil;
    var dataArr:[String]! = nil;            //数据源

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initData();
        createView();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() -> Void {
        
        dataArr = ["设备记录数据的上传","设备报告与签名的上传","设备UDI数据的上传","设备ASN数据的上传","邮件发送服务","个人信息"];
    }

    func createView() {
        
        self.view.backgroundColor = UIColor.white;
        
        self.setNavWithTitle("接口调试", leftImage: nil, leftTitle: nil, leftAction: nil, rightImage: nil, rightTitle: nil, rightAction: nil);
        
        tableView = UITableView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NavigationBar_HEIGHT-52));
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView();
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {()->() in
            
            
            DispatchQueue.global().async {
                
                print("tableView head refresh begin");
                Thread.sleep(forTimeInterval: 2);
                print("tableView head refresh end");
                self.tableView.mj_header.endRefreshing();
                
                DispatchQueue.main.async {
                    print("这里返回主线程，写需要主线程执行的代码");
                };
            };
            
        });
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {
            
            DispatchQueue.global().async {
                
                print("tableView foot refresh begin");
                Thread.sleep(forTimeInterval: 2);
                print("tableView foot refresh end");
                
                
                DispatchQueue.main.async {
                    print("这里返回主线程，写需要主线程执行的代码");
                    self.tableView.mj_footer.endRefreshing();
                };
            };
        })
        self.view.addSubview(tableView);
        
        let imageArr:[UIImage] = [UIImage.init(named: "home_focus")!,UIImage.init(named: "home_focus")!,UIImage.init(named: "home_focus")!];
        let titleArr:[String] = ["社交","朋友圈","个人"];
        
        let bottomView:BottomSelectSView = BottomSelectSView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-52, width: SCREEN_WIDTH, height: 52), images: imageArr, selectedImages: nil, titles: titleArr, _titleColor: UIColor.lightGray, _titleSelectedColor: UIColor.red);
        bottomView.delegate = self;
        self.view.addSubview(bottomView);
        
    }
    
    //BottomSelectViewDelegate
    func   didSelectedBottomSelectView(selectView:BottomSelectSView,index:Int,selectedImage:UIImageView,selectedTitle:UILabel) -> Void
    {
        print("index = \(index)");
        if(index==1)
        {
            let vc:FriendController = FriendController();
            self.navigationController?.pushViewController(vc, animated: true);
        }
        
    }
    
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
        cell.textLabel?.text = dataArr[indexPath.row];
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
            //调用OC封装的对话框
//            let alert:SimpleAlertView = SimpleAlertView(alertView: "提示", content: "我的OC弹出框", vi: nil);
//            alert.callBack = {(str,index)->() in
//                
//                if(index==2)
//                {
//                    print("SimpleAlertView");
//                }
//            };
//            
//            alert.show();
        
        if(indexPath.row<4)
        {
            let rc:FileSelectViewController = FileSelectViewController();
            rc.type = 0;
            self.navigationController?.pushViewController(rc, animated: true);
        }
        else
        {
//            PublicFunction.("的范德萨发的范德萨范德萨是的范德萨");
//            let hud:MBProgressHUD = PublicFunction.myShow("的范德萨发的范德萨范德萨是的范德萨");
//            print("hud.size = \(hud.size)");
            switch indexPath.row {
            case 4:
            
                let rc:CollectionViewController = CollectionViewController();
                self.navigationController?.pushViewController(rc, animated: true);
                break;
                
            case 5:
                
                let rc:PersonViewController = PersonViewController();
                self.navigationController?.pushViewController(rc, animated: true);
                break;
            default:
                break;
            }
            
        }

        
    }

}

