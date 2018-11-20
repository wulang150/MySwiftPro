//
//  CommentView.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/12.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import UIKit

let Comment_textFontSize:CGFloat = 12;
let Comment_textPadding:CGFloat = 2;

class CommentView: UIView,UITableViewDelegate,UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var dataArr:[String] = [];
    var model:FriendModel!;
    
    lazy var tableView:UITableView = {
        let tmp:UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: Friend_contentW, height: 0));
        tmp.delegate = self;
        tmp.dataSource = self;
        tmp.tableFooterView = UIView();
        tmp.isScrollEnabled = false;
        return tmp;
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {

        super.init(frame: frame);
        self.addSubview(self.tableView);
    }
    //tableDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
//        let str:String = dataArr[indexPath.row];
//
//        return str.heightWithFont(font: UIFont.systemFont(ofSize: Comment_textFontSize), fixedWidth: Friend_contentW)+Comment_textPadding*2;
        let height = model.commentHArr[indexPath.row];
        return height;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cssell") ;
        
        if(cell==nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cssell");
            let lab:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: Friend_contentW, height: 0));
            lab.numberOfLines = 0;
            lab.font = UIFont.systemFont(ofSize: Comment_textFontSize);
            lab.tag = 10;
            lab.backgroundColor = RGB(r: 231, g: 231, b: 231);
            cell.contentView.addSubview(lab);
            
        }
        
        let lab:UILabel = cell.contentView.viewWithTag(10) as! UILabel;
        let str:String = dataArr[indexPath.row];
        
//        let height = str.heightWithFont(font: UIFont.systemFont(ofSize: Comment_textFontSize), fixedWidth: Friend_contentW)+Comment_textPadding*2;
        let height = model.commentHArr[indexPath.row];
        lab.frame.size.height = height;
        lab.text = str;
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        
        let alertCtl:UIAlertController = UIAlertController(title: "操作", message: "", preferredStyle: UIAlertControllerStyle.actionSheet);
        
        let delAction:UIAlertAction = UIAlertAction(title: "删除", style: UIAlertActionStyle.destructive) { (action) in
            print(">>>>>>>>>删除")
        };
        
        let cancelAction:UIAlertAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (action) in
            
            print(">>>>>>>>>取消")
        };
        alertCtl.addAction(delAction);
        alertCtl.addAction(cancelAction);
        UIApplication.shared.keyWindow?.rootViewController?.present(alertCtl, animated: true, completion: nil);
    }
    
    func setData(_model:FriendModel) -> () {

        model = _model;
        dataArr = model.commentArr;
        self.tableView.frame.size.height = self.classForCoder.gainHeight(model: model);
        self.tableView.reloadData();
    }
    
    static func gainHeight(model:FriendModel) -> (CGFloat) {
        
//        var height:CGFloat = 0;
//        for str in arr
//        {
//            height = str.heightWithFont(font: UIFont.systemFont(ofSize: Comment_textFontSize), fixedWidth: Friend_contentW)+Comment_textPadding*2 + height;
//        }
//        return height;
        return model.commentH;
    }
}

extension CommentView{
    
    
}
