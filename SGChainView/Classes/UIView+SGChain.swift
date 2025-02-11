//
//  UIView+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit
import SnapKit

extension UIView:JYCompatible{ }

private struct AssociatedKeys {
    static var layoutOptions = UnsafeRawPointer(bitPattern: "layoutOptionsKey".hashValue)!
    static var blockTarget = "btnBlockTarget"
}

public extension JYSpeedy where Base: UIView {
    // 定义布局属性的结构体，存储视图约束相关的信息
    private struct LayoutOptions {
        var top: CGFloat?
        var left: CGFloat?
        var bottom: CGFloat?
        var right: CGFloat?
        var width: CGFloat?
        var height: CGFloat?
        var centerX: CGFloat?
        var centerY: CGFloat?
    }
    
    private var blockTarget: CSTapGestureBlockTarget? {
        get {
            return withUnsafePointer(to: &AssociatedKeys.blockTarget) {
                return objc_getAssociatedObject(base, $0)
            } as? CSTapGestureBlockTarget
        }
        set {
            withUnsafePointer(to: &AssociatedKeys.blockTarget) {
                objc_setAssociatedObject(base, $0, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    // 关联对象 getter 和 setter
    private var layoutOptions: LayoutOptions {
        get {
            if let options = objc_getAssociatedObject(base, &AssociatedKeys.layoutOptions) as? LayoutOptions {
                return options
            }
            return LayoutOptions()  // 如果没有，返回默认值
        }
        set {
            objc_setAssociatedObject(base, &AssociatedKeys.layoutOptions, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    //  链式设置 width 约束
    @discardableResult func width(_ value: CGFloat) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.width = value
        layoutOptions = options
        return self
    }
    
    //  链式设置 height 约束
    @discardableResult func height(_ value: CGFloat) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.height = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 top 约束
    @discardableResult func top(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.top = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 left 约束
    @discardableResult func left(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.left = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 right 约束
    @discardableResult func right(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.right = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 bottom 约束
    @discardableResult func bottom(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.bottom = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 centerX 约束
    @discardableResult func centerX(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.centerX = value
        layoutOptions = options
        return self
    }
    
    // 链式设置 centerY 约束
    @discardableResult func centerY(_ value: CGFloat = 0) -> JYSpeedy<Base> {
        var options = layoutOptions
        options.centerY = value
        layoutOptions = options
        return self
    }
    
    /// snpFast 方法，根据链式调用设置的属性进行布局
    @discardableResult func snpFast() -> JYSpeedy<Base> {
        base.snp.makeConstraints { make in
            let options = layoutOptions
            
            // 应用宽度和高度约束
            if let width = options.width {
                make.width.equalTo(width)
            }
            if let height = options.height {
                make.height.equalTo(height)
            }
            
            // 应用边距约束
            if let top = options.top {
                make.top.equalToSuperview().offset(top)
            }
            if let left = options.left {
                make.left.equalToSuperview().offset(left)
            }
            if let right = options.right {
                make.right.equalToSuperview().offset(-right)
            }
            if let bottom = options.bottom {
                make.bottom.equalToSuperview().offset(-bottom)
            }
            
            // 应用中心约束
            if let centerX = options.centerX {
                make.centerX.equalToSuperview().offset(centerX)
            }
            if let centerY = options.centerY {
                make.centerY.equalToSuperview().offset(centerY)
            }
        }
        return self
    }
    
    
    @discardableResult func backGroundColor(_ color:UIColor?) -> JYSpeedy<Base>{
        base.backgroundColor = color
        return self
    }
    
    @discardableResult func cornerRadius(_ radius:CGFloat) -> JYSpeedy<Base>{
        base.layer.cornerRadius = radius
        base.clipsToBounds = true
        if #available(iOS 13.0, *) {
            base.layer.cornerCurve = .continuous
        }
        return self
    }
    
    @discardableResult func borderColor(_ color:UIColor) -> JYSpeedy<Base>{
        base.layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult func borderWidth(_ width:CGFloat) -> JYSpeedy<Base>{
        base.layer.borderWidth = width
        return self
    }
    
    @discardableResult func tintColor(_ color:UIColor) -> JYSpeedy<Base>{
        base.tintColor = color
        return self
    }
    
    @discardableResult func isHidden(_ hidden:Bool) -> JYSpeedy<Base>{
        base.isHidden = hidden
        return self
    }
    
    @discardableResult func isUserInteractionEnabled(_ enabled:Bool) -> JYSpeedy<Base>{
        base.isUserInteractionEnabled = enabled
        return self
    }
    
    @discardableResult func addToSuperView(_ superView:UIView) -> JYSpeedy<Base>{
        superView.addSubview(base)
        return self
    }
    
    @discardableResult func snp(_ closure: (_ make: ConstraintMaker) -> Void) -> JYSpeedy<Base>{
        base.snp.makeConstraints(closure)
        return self
    }
    
    @discardableResult func snpRemake(_ closure: (_ make: ConstraintMaker) -> Void) -> JYSpeedy<Base>{
        base.snp.remakeConstraints(closure)
        return self
    }
}

public extension JYSpeedy where Base: UIImageView {
    
    @discardableResult func image(_ image: UIImage?) -> JYSpeedy<Base>{
        base.image = image
        return self
    }
    
    @discardableResult func imageNamed(_ imageNamed: String) -> JYSpeedy<Base>{
        base.image = UIImage(named: imageNamed)
        return self
    }
    
    @discardableResult func contentModel(_ contentMode: UIView.ContentMode) -> JYSpeedy<Base>{
        base.contentMode = contentMode
        return self
    }
    
    @discardableResult func alpha(_ value: CGFloat) -> JYSpeedy<Base> {
        base.alpha = value
        return self
    }
    
    @discardableResult func transformRotation(_ angle: CGFloat) -> JYSpeedy<Base> {
        base.transform = base.transform.rotated(by: angle)
        return self
    }
    
    @discardableResult func transformScale(_ scale: CGFloat) -> JYSpeedy<Base> {
        base.transform = base.transform.scaledBy(x: scale, y: scale)
        return self
    }
    
    @discardableResult func shadow(color: UIColor,
                                   offset: CGSize,
                                   opacity: Float,
                                   radius: CGFloat) -> JYSpeedy<Base> {
        base.layer.shadowColor = color.cgColor
        base.layer.shadowOffset = offset
        base.layer.shadowOpacity = opacity
        base.layer.shadowRadius = radius
        return self
    }
    
    @discardableResult
    func tapGesture(_ action: @escaping (UITapGestureRecognizer) -> Void) -> JYSpeedy<Base> {
        let tapGesture = UITapGestureRecognizer()
        let target = CSTapGestureBlockTarget(action)
        base.isUserInteractionEnabled = true
        tapGesture.addTarget(target, action: #selector(CSTapGestureBlockTarget.invokeAction(sender:)))
        base.addGestureRecognizer(tapGesture)
        blockTarget = target
        
        return self
    }
}

class CSTapGestureBlockTarget {
    private let action: (UITapGestureRecognizer) -> Void
    
    init(_ action: @escaping (UITapGestureRecognizer) -> Void) {
        self.action = action
    }
    
    @objc func invokeAction(sender: UITapGestureRecognizer) {
        action(sender)
    }
}

extension UIImageView {
    
    func setImage(_ image: UIImage?, duration: CFTimeInterval = 0.2, animated: Bool = true) {
        if let image = image {
            if animated {
                UIView.transition(
                    with: self,
                    duration: duration,
                    options: [.transitionCrossDissolve, .curveEaseInOut, .allowUserInteraction]
                ) {
                    self.image = image
                }
            }else {
                self.image = image
            }
        }
    }
}
