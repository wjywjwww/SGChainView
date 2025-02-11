//
//  UILabel+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit

public extension JYSpeedy where Base: UILabel {
    @discardableResult func textColor(_ color:UIColor) -> JYSpeedy<Base>{
        base.textColor = color
        return self
    }
    
    @discardableResult func text(_ text:String) -> JYSpeedy<Base>{
        base.text = text
        return self
    }
    
    @discardableResult func font(_ font:UIFont?) -> JYSpeedy<Base>{
        base.font = font
        return self
    }
    
    @discardableResult func textAlignment(_ textAlignment:NSTextAlignment) -> JYSpeedy<Base>{
        base.textAlignment = textAlignment
        return self
    }
    
    @discardableResult func numberOfLines(_ numberOfLines:Int) -> JYSpeedy<Base>{
        base.numberOfLines = numberOfLines
        return self
    }
}
