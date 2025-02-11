//
//  SGChainBase.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
public protocol JYCompatible {
    associatedtype CompatibleType
    var jy: CompatibleType { get }
}

public extension JYCompatible {
    var jy: JYSpeedy<Self> {
        return JYSpeedy(self)
    }
}

public final class JYSpeedy<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

