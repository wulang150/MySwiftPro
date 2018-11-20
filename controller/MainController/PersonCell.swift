//
//  PersonCell.swift
//  MySwiftPro
//
//  Created by  Tmac on 2017/10/13.
//  Copyright © 2017年 Tmac. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var headImage:UIImage!;
    var content:String!;
    
    
    init(img:UIImage,text:String){
        headImage = img;
        content = text;
    }
}

class PersonCell: UITableViewCell {
    
    var headImageView: UIImageView!;
    var contentLab: UILabel!;
    static var height:CGFloat = 60;
    
    private var per:Person!;

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
        
        let imgw:CGFloat = PersonCell.height-4*2;
        headImageView = UIImageView(frame: CGRect(x: 6, y: 4, width: imgw, height: imgw));
        headImageView.isUserInteractionEnabled = false;
        self.contentView.addSubview(headImageView);
        
        contentLab = UILabel(frame: CGRect(x: headImageView.frame.maxX+6, y: 0, width: self.bounds.width-headImageView.frame.maxX-12, height: PersonCell.height));
        contentLab.font = UIFont.systemFont(ofSize: 13);
        contentLab.numberOfLines = 0;
        self.contentView.addSubview(contentLab);
        
    }
    
    func setPerson(person:Person) -> Void {
        
        per = person;
        
        headImageView.image = per.headImage;
        contentLab.text = per.content;
    }

    
}
