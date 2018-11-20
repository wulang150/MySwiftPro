//
//  FriendController.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/12.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import UIKit

class FriendController: BaseController,UIScrollViewDelegate {
    
    var titleH:CGFloat = 0;
    var titleFont:UIFont!;
    var preY:CGFloat = 0;
    var isShrink:Bool = false;
    var navView:UIView!;
    var dataArr:[FriendModel]! = [];
    lazy var tableView:UITableView = {
//        ()->UITableView in
        let tmp:UITableView = UITableView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-NavigationBar_HEIGHT));
        tmp.delegate = self;
        tmp.dataSource = self;
        tmp.tableFooterView = UIView();
        return tmp;
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navView = self.setNavWithTitle("朋友圈", leftImage: "arrow", leftTitle: nil, leftAction: nil, rightImage: nil, rightTitle: nil, rightAction: nil);
        titleFont = self.navtitleLab.font;
        titleH = self.navtitleLab.height();
        //加入点击事件
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction));
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        navView.addGestureRecognizer(tap);
        
        self.initData();
        self.view.addSubview(tableView);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapAction() -> () {
        
        self.navOpt(isUp: true);
    }
    
    func initData() -> () {
        let model1:FriendModel = FriendModel();
        model1.headUrl = "https://gss2.bdstatic.com/9fo3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268/sign=a8324ff660d0f703e6b292da30fb5148/500fd9f9d72a6059070cf8fb2a34349b033bba36.jpg";
        model1.name = "name1";
        model1.content = "【编前语】我国既是陆地大国，也是海洋大国，拥有广泛的海洋战略利益。“建设海洋强国，我一直有这样一个信念。”推进海洋强国建设是总书记念兹在兹的大事。7月11日是中国航海日，新华社《学习进行时》推出文章，与您一起感受总书记的“海洋情怀”";
        model1.commentArr = ["我国既是陆地大国","也是海洋大国，拥有广泛的海洋战略利益，海洋战略利益","推进海洋强国建设是总书记念兹在兹的大事。7月11日是中国航海日","新华社《学习进行时》推出文章"];
//        model1.imageArr = ["https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3611980675,1711935359&fm=27&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531397087113&di=5a0d4dc77144e3422d00acce9d41bc68&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F54fbb2fb43166d221bc3c416462309f79152d2f8.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531397087113&di=17ac4919f37ec87dda14421750dd5cf7&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01dc9659589416a8012193a3aa0dde.jpg%401280w_1l_2o_100sh.jpg"];
        
        let model2:FriendModel = FriendModel();
        model2.headUrl = "";
        model2.name = "name2";
        model2.content = "建设海洋强国是中国特色社会主义事业的重要组成部分。党的十八大作出了建设海洋强国的重大部署。实施这一重大部署，对推动经济持续健康发展，对维护国家主权、安全、发展利益，对实现全面建成小康社会目标、进而实现中华民族伟大复兴都具有重大而深远的意义";
        model2.commentArr = ["我国既是陆地大国","也是海洋大国，拥有广泛的海洋战略利益","推进海洋强国建设是总书记念兹在兹的大事。7月11日是中国航海日","新华社《学习进行时》推出文章"];
//        model2.imageArr = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531397087112&di=13ad4052290a69cf2a9a7c8061608aa4&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201508%2F06%2F20150806143051_KACfE.jpeg"];
        model2.imageArr = ["https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3611980675,1711935359&fm=27&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531397087113&di=5a0d4dc77144e3422d00acce9d41bc68&imgtype=0&src=http%3A%2F%2Fe.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F54fbb2fb43166d221bc3c416462309f79152d2f8.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531397087113&di=17ac4919f37ec87dda14421750dd5cf7&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01dc9659589416a8012193a3aa0dde.jpg%401280w_1l_2o_100sh.jpg"];
        
        let model3:FriendModel = FriendModel();
        model3.headUrl = "";
        model3.name = "name3";
        model3.content = "海南是海洋大省，要坚定走人海和谐、合作共赢的发展道路，提高海洋资源开发能力，加快培育新兴海洋产业，支持海南建设现代化海洋牧场，着力推动海洋经济向质量效益型转变。要发展海洋科技，加强深海科学技术研究，推进“智慧海洋”建设，把海南打造成海洋强省。要打造国家军民融合创新示范区，统筹海洋开发和海上维权，推进军地共商、科技共兴、设施共建、后勤共保，加快推进南海资源开发服务保障基地和海上救援基地建设，坚决守好祖国南大门";
        model3.commentArr = ["我国既是陆地大国","也是海洋大国，拥有广泛的海洋战略利益","推进海洋强国建设是总书记念兹在兹的大事。7月11日是中国航海日","新华社《学习进行时》推出文章"];
        
        let model4:FriendModel = FriendModel();
        model4.headUrl = "";
        model4.name = "name4";
        model4.content = "海南是海洋大省，要坚定走人海和谐、合作共赢的发展道路，提高海洋资源开发能力，加快培育新兴海洋产业，支持海南建设现代化海洋牧场，着力推动海洋经济向质量效益型转变。要发展海洋科技，加强深海科学技术研究，推进“智慧海洋”建设，把海南打造成海洋强省。要打造国家军民融合创新示范区，统筹海洋开发和海上维权，推进军地共商、科技共兴、设施共建、后勤共保，加快推进南海资源开发服务保障基地和海上救援基地建设，坚决守好祖国南大门，我国既是陆地大国，也是海洋大国，拥有广泛的海洋战略利益";
//        model3.commentArr = ["我国既是陆地大国","也是海洋大国，拥有广泛的海洋战略利益","推进海洋强国建设是总书记念兹在兹的大事。7月11日是中国航海日","新华社《学习进行时》推出文章"];
        
        let tmpArr:[FriendModel] = [model1,model2,model3,model4];
        
        for index in 0...100 {
            let i = index%4;
            let model:FriendModel = tmpArr[i];
            dataArr.append(model);
        }

    }
    
    //导航条收缩与展开
    func navOpt(isUp:Bool) {
        if(isUp)
        {
            if(isShrink==true)      //前个状态是收缩的，才执行展开操作
            {
                self.navView.layer.removeAllAnimations();
                self.navtitleLab.layer.removeAllAnimations();
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.navView.setHeight(64);
                    self.navtitleLab.setCenterY(20+(self.navView.mj_h-20)/2);
                    
                    self.tableView.frame = CGRect(x: 0, y: self.navView.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-self.navView.frame.maxY);
                }, completion: { (succ) in
                    self.navleftBtn.isHidden = false;
                });
                
                let aniScale:CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale");
                aniScale.fromValue = 0.6;
                aniScale.toValue = 1.0;
                aniScale.duration = 0.5;
                aniScale.isRemovedOnCompletion = false;
                aniScale.fillMode = kCAFillModeForwards;
                self.navtitleLab.layer.add(aniScale, forKey: "babyCoin_scale");
                isShrink = false;
            }
        }
        else
        {
            if(isShrink==false)
            {
                self.navView.layer.removeAllAnimations();
                self.navtitleLab.layer.removeAllAnimations();
                UIView.animate(withDuration: 0.5, animations: {
                    
                    self.navView.setHeight(64-20);
                    self.navleftBtn.isHidden = true;
                    self.navtitleLab.setCenterY(20+(self.navView.mj_h-20)/2);
                    
                    self.tableView.frame = CGRect(x: 0, y: self.navView.frame.maxY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-self.navView.frame.maxY);
                    
                });
                let aniScale:CABasicAnimation = CABasicAnimation.init(keyPath: "transform.scale");
                aniScale.fromValue = 1.0;
                aniScale.toValue = 0.6;
                aniScale.duration = 0.5;
                aniScale.isRemovedOnCompletion = false;
                aniScale.fillMode = kCAFillModeForwards;
                self.navtitleLab.layer.add(aniScale, forKey: "babyCoin_scale");
                
                isShrink = true;
            }
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView)
    {
        let y:CGFloat = scrollView.contentOffset.y;
        preY = y;
    }
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool)
    {
        let y:CGFloat = scrollView.contentOffset.y;
//        print(">>>%f  %f",y,preY);
        if(y>preY)  //向上 与拖开始的位置比较
        {
            self.navOpt(isUp: false);
        }
        if(preY-y>180||y<=0)  //向下
        {
            self.navOpt(isUp: true);
        }
    }
    
//    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView)
//    {
//        let y:CGFloat = scrollView.contentOffset.y;
//        print("---%f",y);
//    }
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        let y:CGFloat = scrollView.contentOffset.y;
//        print("+++%f",y);
        if(y<=0)
        {
            self.navOpt(isUp: true);
        }
    }

}


extension FriendController:UITableViewDelegate,UITableViewDataSource{
    
    //tableDelegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let model:FriendModel = dataArr[indexPath.row];
        return FriendCell.getHeight(model: model);
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
            cell = FriendCell(style: UITableViewCellStyle.default, reuseIdentifier: "cssell");
        }
        let mycell:FriendCell = cell as! FriendCell;
        let model:FriendModel = dataArr[indexPath.row];
        mycell.setModel(model: model);
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true);
        
    }
}
