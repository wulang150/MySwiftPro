//
//  BottomSelectSView.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/10/10.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit

protocol BottomSelectViewDelegate:NSObjectProtocol {
    
     func didSelectedBottomSelectView(selectView:BottomSelectSView,index:Int,selectedImage:UIImageView,selectedTitle:UILabel) -> Void ;
}

class BottomSelectSView: UIView {

    var imgW:CGFloat = 0;
    var imgH:CGFloat = 0;
    var font:UIFont!;
    var imageViewArr:[UIImageView]!;
    var titleViewArr:[UILabel]!;
    weak open var delegate: BottomSelectViewDelegate?
    
    private var imageArr:[UIImage]!;
    private var imageSelectedArr:[UIImage]!;
    private var titleArr:[String]!;
    private var titleColor:UIColor!;
    private var titleSelectedColor:UIColor!;
    private var num:Int = 0;
    
    init(frame:CGRect,images:[UIImage]!,selectedImages:[UIImage]!,titles:[String],_titleColor:UIColor!,_titleSelectedColor:UIColor!){
        
        super.init(frame: frame);
        self.imageArr = images;
        self.imageSelectedArr = selectedImages;
        self.titleArr = titles;
        self.titleColor = _titleColor != nil ? _titleColor : UIColor.gray;
        self.titleSelectedColor = _titleSelectedColor;
        
        self.num = NUM(arr: titleArr)>NUM(arr: images) ? NUM(arr: titleArr) : NUM(arr: images);
        
        self.backgroundColor = UIColor.white;
        
        createView();
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView() -> Void {
        
        if(num <= 0)
        {
            return;
        }
        let w:CGFloat = self.bounds.size.width/CGFloat(num);
        var _imgW:CGFloat = w*2/5;
        var _imgH:CGFloat = self.bounds.size.height/2;
        _imgH = _imgW>_imgH ? _imgH : _imgW;
        _imgW = _imgH;
        if(imgH<=0)
        {
            imgH = _imgH;
        }
        if(imgW<=0)
        {
            imgW = _imgW;
        }
        
        if(font != nil)
        {
            font = UIFont.systemFont(ofSize: 12);
        }
        
        var imageMul:[UIImageView] = [];
        var titleMul:[UILabel] = [];
        
        for i in 0 ..< num
        {
            let btn:UIButton = UIButton(type: UIButtonType.custom);
            btn.tag = i;
            btn.frame = CGRect(x: CGFloat(i)*w, y: 0, width: w, height: self.bounds.size.height);
            btn.addTarget(self, action: #selector(buttonAction(sender:)), for: UIControlEvents.touchUpInside);
            self.addSubview(btn);
            
            //图片
            let imageView:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imgW, height: imgH));
            if(i>=NUM(arr: imageArr))
            {
                imageView.frame = CGRect.zero;
            }
            else
            {
                let image:UIImage = imageArr[i];
                if(image.isKind(of: UIImage.self))
                {
                    imageView.image = image;
                }
                else
                {
                    imageView.frame = CGRect.zero;
                }
            }
            imageView.isUserInteractionEnabled = false;
            imageView.clipsToBounds = true;
            
            //标题
            let titleLab:UILabel = UILabel(frame: CGRect(x: 0, y: 4, width: 0, height: 0));
            titleLab.textColor = titleColor;
            titleLab.font = font;
            if(i<NUM(arr: titleArr))
            {
                titleLab.text = titleArr[i];
            }
            titleLab.isUserInteractionEnabled = false;
            
            let view:UIView = CommonFun.fit(toCenter: btn, childs: [imageView,titleLab], subAlign: 1, isHor: false);
            view.isUserInteractionEnabled = false;
            
            imageMul.append(imageView);
            titleMul.append(titleLab);
        }
        
        imageViewArr = imageMul;
        titleViewArr = titleMul;
    }
    
    func buttonAction(sender:UIButton) -> Void {
        
        //全部恢复原始状态
        var i:Int = 0;
        for imageView in imageViewArr
        {
            if(i>=NUM(arr: imageArr))
            {
                break;
            }
            
            let image:UIImage = imageArr[i];
            if(image.isKind(of: UIImage.self))
            {
                continue;
            }
            imageView.image = image;
            i += 1;
        }
        
        for lab in titleViewArr
        {
            lab.textColor = titleColor;
        }
        
        //设置选中的状态
        let selectedImageView:UIImageView = imageViewArr[sender.tag];
        let selectedTitleView:UILabel = titleViewArr[sender.tag];
        
        if(sender.tag<NUM(arr: imageSelectedArr))
        {
            selectedImageView.image = imageSelectedArr[sender.tag];
        }
        
        if(titleSelectedColor != nil)
        {
            selectedTitleView.textColor = titleSelectedColor;
        }
        
//        if(self.delegate!.responds(to: #selector(BottomSelectViewDelegate.didSelectedBottomSelectView(selectView:index:selectedImage:selectedTitle:))))
//        {
//            
//        }
        
        self.delegate?.didSelectedBottomSelectView(selectView: self, index: sender.tag, selectedImage: selectedImageView, selectedTitle: selectedTitleView);
    }

}
