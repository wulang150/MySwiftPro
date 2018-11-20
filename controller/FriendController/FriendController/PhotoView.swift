//
//  PhotoView.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/12.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import UIKit

class PhotoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var model:FriendModel!;
    var imageViewArr:[UIImageView]!;
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        self.createView();
    }
    
    func createView() -> () {
        imageViewArr = [];
        var x:CGFloat = 0;
        var y:CGFloat = 0;
        for index in 0...8
        {
            let i1:Int = index%3;
            let i2:Int = index/3;
            x = (CGFloat)(i1)*(Friend_imgH+Friend_leftPadding);
            y = (CGFloat)(i2)*(Friend_imgH+Friend_leftPadding);
            let imageView:UIImageView = UIImageView(frame: CGRect(x: x, y: y, width: Friend_imgH, height: Friend_imgH));
            imageViewArr.append(imageView);
            self.addSubview(imageView);
        }
    }
    
    func setData(_model:FriendModel) -> () {
        if(_model.imageArr.count<=0)
        {
            for i in 0...8
            {
                let imageView:UIImageView = self.imageViewArr[i];
                imageView.isHidden = true;
            }
            return;
        }
        model = _model;
        for i in 0...model.imageArr.count-1
        {
            let imageView:UIImageView = self.imageViewArr[i];
            imageView.isHidden = false;
            imageView.sd_setImage(with: URL(string: model.imageArr[i]), placeholderImage: UIImage.init(named: "duomi_music"));
        }
    }
    
    static func gainHeight(model:FriendModel) -> (CGFloat) {
        if(model.imageArr.count<=0)
        {
            return 0;
        }
        let row:Int = (model.imageArr.count-1)/3+1;
        let row1:CGFloat = CGFloat(row);
        return row1*Friend_imgH+((CGFloat)(row1-1))*Friend_leftPadding;
    }

}
