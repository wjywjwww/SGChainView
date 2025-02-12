//
//  UIButton+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit
import QMUIKit
import SnapKit

private struct AssociatedKeys {
    static var blockTarget = "btnBlockTarget"
}

public extension JYSpeedy where Base: UIButton {
    
    private var blockTarget: CSButtonBlockTarget? {
        get {
            return withUnsafePointer(to: &AssociatedKeys.blockTarget) {
                return objc_getAssociatedObject(base, $0)
            } as? CSButtonBlockTarget
        }
        set {
            withUnsafePointer(to: &AssociatedKeys.blockTarget) {
                objc_setAssociatedObject(base, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @discardableResult func title(_ title: String?, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setTitle(title, for: state)
        return self
    }
    
    @discardableResult func attributedTitle(_ attributedTitle: NSAttributedString?, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setAttributedTitle(attributedTitle, for: state)
        return self
    }
    
    @discardableResult func titleColor(_ color: UIColor?, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setTitleColor(color, for: state)
        return self
    }
    
    @discardableResult func titleShadow(_ color: UIColor?) -> JYSpeedy<Base>{
        base.setTitleShadowColor(color, for: .normal)
        base.titleLabel?.layer.shadowOpacity = 1.0
        base.titleLabel?.layer.shadowOffset = CGSize(width: 0, height: 1)
        base.titleLabel?.layer.shadowRadius = 0.5
        return self
    }
    
    @discardableResult func enabled(_ isEnabled: Bool) -> JYSpeedy<Base>{
        base.isEnabled = isEnabled
        return self
    }
    
    @discardableResult func isSelected(_ isSelected: Bool) -> JYSpeedy<Base>{
        base.isSelected = isSelected
        return self
    }
    
    @discardableResult func image(_ image: UIImage?, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setImage(image, for: state)
        return self
    }
    
    @discardableResult func imageNamed(_ imageNamed: String, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setImage(UIImage(named: imageNamed), for: state)
        return self
    }
    
    @discardableResult func backgroundImage(_ image: UIImage?, for state: UIControl.State = .normal) -> JYSpeedy<Base>{
        base.setBackgroundImage(image, for: state)
        return self
    }
    
    @discardableResult func font(_ font:UIFont?) -> JYSpeedy<Base>{
        base.titleLabel?.font = font
        return self
    }
    
    @discardableResult func addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event = .touchUpInside) -> JYSpeedy<Base> {
        base.addTarget(target, action: action, for: controlEvents)
        return self
    }
    
    @discardableResult func onTouchUpInside(_ block: @escaping (UIButton) -> Void) -> JYSpeedy<Base> {
        let target = CSButtonBlockTarget(block)
        blockTarget = target
        base.addTarget(target, action: #selector(CSButtonBlockTarget.invokeAction(sender:)), for: .touchUpInside)
        return self
    }
}

private class CSButtonBlockTarget {
    private let block: (UIButton) -> Void
    init(_ block: @escaping (UIButton) -> Void) {
        self.block = block
    }

    @objc func invokeAction(sender:UIButton) {
        block(sender)
    }
}
