//
//  UITextField + SGChain.swift
//  Pods
//
//  Created by szcck005 on 2025/2/11.
//
import Foundation
import QMUIKit

private struct AssociatedKeys {
    static var tfBlockTarget = "tfBlockTarget"
}

public extension JYSpeedy where Base: UITextField {
    
    private var blockTarget: CSTFBlockTarget? {
        get {
            return withUnsafePointer(to: &AssociatedKeys.tfBlockTarget) {
                return objc_getAssociatedObject(base, $0)
            } as? CSTFBlockTarget
        }
        set {
            withUnsafePointer(to: &AssociatedKeys.tfBlockTarget) {
                objc_setAssociatedObject(base, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    @discardableResult func font(_ font:UIFont?) -> JYSpeedy<Base>{
        base.font = font
        return self
    }
    
    @discardableResult func keyboardType(_ keyboardType:UIKeyboardType) -> JYSpeedy<Base>{
        base.keyboardType = keyboardType
        return self
    }
    
    @discardableResult func textColor(_ color:UIColor) -> JYSpeedy<Base>{
        base.textColor = color
        return self
    }
    
    @discardableResult func valueChange(_ block: @escaping (String) -> Void) -> JYSpeedy<Base> {
        let target = CSTFBlockTarget(block)
        blockTarget = target
        base.addTarget(target, action: #selector(CSTFBlockTarget.invoke(sender:)), for: .editingChanged)
        return self
    }
}

private class CSTFBlockTarget {
    private let block: (String) -> Void
    init(_ block: @escaping (String) -> Void) {
        self.block = block
    }

    @objc func invoke(sender:UITextField) {
        block(sender.text ?? "")
    }
}
