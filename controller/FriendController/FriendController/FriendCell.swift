//
//  FriendCell.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/12.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import UIKit

let Friend_TopPadding:CGFloat = 6;
let Friend_leftPadding:CGFloat = 6;
let Friend_contentFontSize:CGFloat = 13;
let Friend_headImageH:CGFloat = 50;
let Friend_contentW:CGFloat = 240;
let Friend_nameH:CGFloat = 32;
let Friend_imgH:CGFloat = (Friend_contentW - Friend_leftPadding*2)/3;

class FriendModel: NSObject {
    
    var headUrl:String = "";
    var name:String = ""
    var imageArr:[String] = [];
    var content:String = ""{
        didSet{
            contentH = content.heightWithFont(font: UIFont.systemFont(ofSize: Friend_contentFontSize), fixedWidth: Friend_contentW);
        }
    }
    var commentArr:[String] = []{
        
        didSet{
            commentHArr = [];
            for str in commentArr
            {
                let height:CGFloat = str.heightWithFont(font: UIFont.systemFont(ofSize: Comment_textFontSize), fixedWidth: Friend_contentW)+Comment_textPadding*2;
                commentHArr.append(height);
                commentH = commentH + height;
            }
        }
    }
    
    var contentH:CGFloat = 0;
    var commentHArr:[CGFloat] = [];
    var commentH:CGFloat = 0;
    
}

class FriendCell: UITableViewCell {
    
    //头像
    lazy var headImageView:UIImageView = {
        let tmp:UIImageView = UIImageView(frame: CGRect(x: Friend_leftPadding, y: Friend_TopPadding, width: Friend_headImageH, height: Friend_headImageH));
        tmp.layer.cornerRadius = Friend_headImageH/2;
        return tmp;
    }()
    //名字
    lazy var nameLab:UILabel = {
        let tmp:UILabel = UILabel(frame: CGRect(x: self.headImageView.frame.maxX+Friend_leftPadding, y: Friend_TopPadding, width: Friend_contentW, height: Friend_nameH));
        tmp.font = UIFont.systemFont(ofSize: 14);
        return tmp;
    }()
    //内容
    lazy var contentLab:UILabel = {
        let tmp:UILabel = UILabel(frame: CGRect(x: self.nameLab.frame.origin.x, y: self.nameLab.frame.maxY, width: Friend_contentW, height: 32));
        tmp.font = UIFont.systemFont(ofSize: Friend_contentFontSize);
        tmp.numberOfLines = 0;
//        tmp.layer.borderWidth = 1;
        return tmp;
    }()
    //图片
    lazy var photoView:PhotoView = {
        let tmp:PhotoView = PhotoView(frame: CGRect(x: self.nameLab.frame.origin.x, y: 0, width: Friend_contentW, height: 0));
        return tmp;
    }()
    //评论
    lazy var commentView:CommentView = {
        let tmp:CommentView = CommentView(frame: CGRect(x: self.nameLab.frame.origin.x, y: 0, width: Friend_contentW, height: 0));
        return tmp;
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
        
        self.contentView.addSubview(self.headImageView);
        self.contentView.addSubview(self.nameLab);
        self.contentView.addSubview(self.contentLab);
        self.contentView.addSubview(self.commentView);
        self.contentView.addSubview(self.photoView);
    }
    
    func setModel(model:FriendModel) -> Void {
        
        self.headImageView.sd_setImage(with: URL(string: model.headUrl), placeholderImage: UIImage.init(named: "duomi_music"));
        
        self.nameLab.text = model.name;
        self.contentLab.text = model.content;
//        self.contentLab.frame.size.height = model.content.heightWithFont(font: UIFont.systemFont(ofSize: Friend_contentFontSize), fixedWidth: Friend_contentW);
        self.contentLab.frame.size.height = model.contentH;
        
        //图片
        var height:CGFloat = PhotoView.gainHeight(model: model);
        self.photoView.setData(_model: model);
        self.photoView.frame.origin.y = self.contentLab.frame.maxY;
        if(height>0)
        {
            self.photoView.frame.origin.y = self.photoView.frame.origin.y+Friend_TopPadding;
        }
        self.photoView.frame.size.height = height;
        
        height = CommentView.gainHeight(model: model);
        self.commentView.setData(_model: model);
        self.commentView.frame.origin.y = self.photoView.frame.maxY;
        if(height>0)
        {
            self.commentView.frame.origin.y = self.commentView.frame.origin.y+Friend_TopPadding;
        }
        self.commentView.frame.size.height = CommentView.gainHeight(model: model);
        
    }
    
    static func getHeight(model:FriendModel) -> CGFloat {
        var height:CGFloat = 0;
        height = height + Friend_nameH;
        
//        let contentH = model.content.heightWithFont(font: UIFont.systemFont(ofSize: Friend_contentFontSize), fixedWidth: Friend_contentW);
        let contentH = model.contentH;
        if(contentH > 0)
        {
            height = height + contentH;
        }
        
        //图片
        let photoH = PhotoView.gainHeight(model: model);
        if(photoH>0)
        {
            height = height + Friend_TopPadding + photoH;
        }
        
        let comH = CommentView.gainHeight(model: model);
        if(comH>0)
        {
            height = height + Friend_TopPadding + comH;
        }

        height = height + Friend_TopPadding*2;
        
        return height;
    }

}
