//
//  UILabel+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit

public extension SGSpeedy where Base: UILabel {
    @discardableResult func setTextColor(color:UIColor) -> SGSpeedy<Base>{
        base.textColor = color
        return self
    }
    
    @discardableResult func setText(text:String) -> SGSpeedy<Base>{
        base.text = text
        return self
    }
    
    @discardableResult func setFont(font:UIFont) -> SGSpeedy<Base>{
        base.font = font
        return self
    }
    
    @discardableResult func setTextAlignment(textAlignment:NSTextAlignment) -> SGSpeedy<Base>{
        base.textAlignment = textAlignment
        return self
    }
    
    @discardableResult func setNumberOfLines(numberOfLines:Int) -> SGSpeedy<Base>{
        base.numberOfLines = numberOfLines
        return self
    }
}
