//
//  SGChainBase.swift
//  多线程
//
//  Created by Tiank on 2021/8/25.
//

import Foundation
public protocol SGCompatible {
    associatedtype CompatibleType
    var sg: CompatibleType { get }
}

public extension SGCompatible {
    var sg: SGSpeedy<Self> {
        return SGSpeedy(self)
    }
}

public final class SGSpeedy<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

