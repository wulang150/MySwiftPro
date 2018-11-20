//
//  String+StringExtension.swift
//  MySwiftPro
//
//  Created by  Tmac on 2018/7/12.
//  Copyright © 2018年 Tmac. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     Get the height with the string.
     
     - parameter attributes: The string attributes.
     - parameter fixedWidth: The fixed width.
     
     - returns: The height.
     */
    func heightWithStringAttributes(attributes : [String : AnyObject], fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            
            return 0
        }
        
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude);
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil);
        
        return rect.size.height
    }
    
    /**
     Get the height with font.
     
     - parameter font:       The font.
     - parameter fixedWidth: The fixed width.
     
     - returns: The height.
     */
    func heightWithFont(font : UIFont = UIFont.systemFont(ofSize: 18), fixedWidth : CGFloat) -> CGFloat {
        
        guard self.count > 0 && fixedWidth > 0 else {
            
            return 0
        }
        
        let size = CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude);
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil);
        
        return rect.size.height
    }
    
    /**
     Get the width with the string.
     
     - parameter attributes: The string attributes.
     
     - returns: The width.
     */
    func widthWithStringAttributes(attributes : [String : AnyObject]) -> CGFloat {
        
        guard self.count > 0 else {
            
            return 0
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0);
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil);
        
        return rect.size.width
    }
    
    /**
     Get the width with the string.
     
     - parameter font: The font.
     
     - returns: The string's width.
     */
    func widthWithFont(font : UIFont = UIFont.systemFont(ofSize: 18)) -> CGFloat {
        
        guard self.count > 0 else {
            
            return 0
        }
        
        let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 0);
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil);
        
        return rect.size.width
    }
}
