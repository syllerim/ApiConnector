//
//  RoutePath.swift
//  ApiConnector
//
//  Created by Oleksii on 20/01/2017.
//  Copyright © 2017 WeAreReasonablePeople. All rights reserved.
//

import Foundation

public protocol RoutePathComponent {
    var stringValue: String { get }
    var pathValue: String { get }
}

public extension RoutePathComponent {
    public var pathValue: String {
        return RoutePath.separator + stringValue
    }
}

public struct RoutePath {
    fileprivate static let separator = "/"
    fileprivate let path: [RoutePathComponent]
    
    public init(_ path: RoutePathComponent...) {
        self.init(path)
    }
    
    public init(_ path: [RoutePathComponent]) {
        self.path = path
    }
    
    public func with(_ path: RoutePathComponent...) -> RoutePath {
        return RoutePath(self.path + path)
    }
}

extension RoutePath: RoutePathComponent {
    public var stringValue: String {
        return path.map({ $0.stringValue }).joined(separator: RoutePath.separator)
    }
}

extension RoutePath: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: RoutePathComponent...) {
        self.init(elements)
    }
}

public extension RoutePath {
    public static func + (lhs: RoutePath, rhs: RoutePath) -> RoutePath {
        return RoutePath(lhs.path + rhs.path)
    }
}

extension String: RoutePathComponent {
    public var stringValue: String {
        return self
    }
}
