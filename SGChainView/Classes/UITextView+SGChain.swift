//
//  UITextView+CSChain.swift
//  DigitalHuman
//
//  Created by szcck005 on 2024/7/1.
//

import Foundation
import UIKit
import QMUIKit
import ObjectiveC

private struct AssociatedKeys {
    static var tvBlockTarget = "tvBlockTarget"
}

public extension JYSpeedy where Base: UITextView {
    
    private var blockTarget: DHTVBlockTarget? {
        
        get {
            return withUnsafePointer(to: &AssociatedKeys.tvBlockTarget) {
                return objc_getAssociatedObject(base, $0)
            } as? DHTVBlockTarget
        }
        set {
            withUnsafePointer(to: &AssociatedKeys.tvBlockTarget) {
                objc_setAssociatedObject(base, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @discardableResult func font(_ font:UIFont?) -> JYSpeedy<Base> {
        base.font = font
        return self
    }
    
    @discardableResult func text(_ text:String?) -> JYSpeedy<Base> {
        base.text = text
        return self
    }
    
    @discardableResult func keyboardType(_ keyboardType:UIKeyboardType) -> JYSpeedy<Base> {
        base.keyboardType = keyboardType
        return self
    }
    
    @discardableResult func textColor(_ color:UIColor) -> JYSpeedy<Base> {
        base.textColor = color
        return self
    }
    
    @discardableResult func valueChange(_ block: @escaping (String) -> Void) -> JYSpeedy<Base> {
        let target = DHTVBlockTarget(block)
        blockTarget = target
        NotificationCenter.default.addObserver(target, selector: #selector(DHTVBlockTarget.invoke(sender:)), name: UITextView.textDidChangeNotification, object: base)
        return self
    }
}

public extension JYSpeedy where Base: QMUITextView {
    @discardableResult func placeholderColor(_ color:UIColor) -> JYSpeedy<Base> {
        base.placeholderColor = color
        return self
    }
    
    @discardableResult func placeholder(_ text:String) -> JYSpeedy<Base> {
        base.placeholder = text
        return self
    }
}

private class DHTVBlockTarget {
    private let block: (String) -> Void
    
    init(_ block: @escaping (String) -> Void) {
        self.block = block
    }
    
    @objc func invoke(sender: NSNotification) {
        if let textView = sender.object as? UITextView {
            block(textView.text ?? "")
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

