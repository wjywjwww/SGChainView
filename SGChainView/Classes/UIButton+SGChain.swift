//
//  UIButton+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit
extension SGSpeedy where Base: UIButton {
    
    @discardableResult func setTitle(_ title: String?, for state: UIControl.State = .normal) -> SGSpeedy<Base>{
        base.setTitle(title, for: state)
        return self
    }
    
    @discardableResult func setTitleColor(_ color: UIColor?, for state: UIControl.State = .normal) -> SGSpeedy<Base>{
        base.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult func setImage(_ image: UIImage?, for state: UIControl.State) -> SGSpeedy<Base>{
        base.setImage(image, for: state)
        return self
    }
    
    @discardableResult func setBackgroundImage(_ image: UIImage?, for state: UIControl.State = .normal) -> SGSpeedy<Base>{
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult func setAttributedTitle(_ title: NSAttributedString?, for state: UIControl.State = .normal) -> SGSpeedy<Base>{
        base.setAttributedTitle(title, for: state)
        return self
    }
    
    @discardableResult func setFont(font:UIFont) -> SGSpeedy<Base>{
        base.titleLabel?.font = font
        return self
    }
}
