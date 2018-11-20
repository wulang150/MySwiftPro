//
//  PersonViewController.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/10/13.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit

class PersonViewController: BaseController {
    
    var tableView:UITableView!;
    var dataArr:[Person]!;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initData();
        
        self.setNavWithTitle("个人信息", leftImage: "arrow", leftTitle: nil, leftAction: nil, rightImage: nil, rightTitle: nil, rightAction: nil);
        
        self.view.addSubview(self.getTableView());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initData() -> Void{
        
        let per1:Person = Person(img: UIImage.init(named: "duomi_music")!, text: "大幅度第三方额个个二维个对方");
        let per2:Person = Person(img: UIImage.init(named: "duomi_music")!, text: "额人如同他同意有个个个如同非非");
        dataArr = [per1,per2];
    }
    
    func getTableView() -> UITableView {
        
        if(tableView==nil)
        {
            tableView = UITableView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT));
            tableView.delegate = self;
            tableView.dataSource = self;
            tableView.tableFooterView = UIView();
        }
        
        return tableView;
    }

}

extension PersonViewController:UITableViewDelegate,UITableViewDataSource{
    
    //tableDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return PersonCell.height;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell:UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "cssell");
        
        if(cell==nil)
        {
            cell = PersonCell(style: UITableViewCellStyle.default, reuseIdentifier: "cssell");
        }
        
        let mycell:PersonCell = cell as! PersonCell;
        //        print("height = \(tableView.rowHeight)");
        let per:Person = dataArr[indexPath.row];
        mycell.setPerson(person: per);
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
}
