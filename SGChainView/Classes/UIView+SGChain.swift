//
//  UIView+SGChain.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
import UIKit

extension UIView:SGCompatible{ }

public extension SGSpeedy where Base: UIView {
    @discardableResult func setBackGroundColor(color:UIColor) -> SGSpeedy<Base>{
        base.backgroundColor = color
        return self
    }
}
