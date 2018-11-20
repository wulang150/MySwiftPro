//
//  CollectionViewController.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/8/9.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit


class CollectionViewController: BaseController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    private var collection:UICollectionView!;

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
        
    }
    
    func createView() -> Void {
        
        setNavWithTitle("第二", leftImage: "arrow", leftTitle: nil, leftAction: nil, rightImage: nil, rightTitle: nil, rightAction: nil);
        
//        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout();
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
//        layout.minimumLineSpacing = 0;
        
        let layout:MyCollectionLayout = MyCollectionLayout();
//        layout.scrollDirection = UICollectionViewScrollDirection.horizontal;
//        layout.sectionInset = UIEdgeInsetsMake(20, 30, 20, 30);
        
        collection = UICollectionView(frame: CGRect(x: 0, y: NavigationBar_HEIGHT, width: SCREEN_WIDTH, height: 220), collectionViewLayout: layout);
        collection.delegate = self;
        collection.dataSource = self;
//        collection.isPagingEnabled = true;
        collection.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "collection");
        self.view.addSubview(collection);
        collection.scrollToItem(at: IndexPath(row: 500, section: 0), at: UICollectionViewScrollPosition.centeredHorizontally, animated: true);
        
//        layout.itemSize = CGSize(width: collection.bounds.size.width-60, height: 140);
        
    }

    //UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 1000;
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath);
        
        let red:CGFloat = CGFloat(CGFloat(arc4random()%255)/255.0);
        let green:CGFloat = CGFloat(CGFloat(arc4random()%255)/255.0);
        let blue:CGFloat = CGFloat(CGFloat(arc4random()%255)/255.0);
        cell.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1);
        
//        print("index = \(indexPath.row)");
        return cell;
    }

}
