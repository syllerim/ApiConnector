//
//  RouterTests.swift
//  ApiConnector
//
//  Created by Oleksii on 01/11/2016.
//  Copyright © 2016 WeAreReasonablePeople. All rights reserved.
//

import XCTest
import ApiConnector

class RouterTests: XCTestCase {
    
    enum TestRouter: ApiRouter {
        typealias EnvironmentType = Environment
        case test
        var route: URLRoute { return .init(["test"]) }
    }
    
    func testRouterUrlCreation() {
        XCTAssertEqual(Router.me.url(for: .test).absoluteString, "http://test.com/api/model/me")
        XCTAssertEqual(Router.pictures.url(for: .test).absoluteString, "http://test.com/api/model/pictures")
        XCTAssertEqual(Router.pictures.url(for: .localhost).absoluteString, "http://localhost:8080/api/model/pictures")
        XCTAssertEqual(Router.posts(userId: "myId").url(for: .test).absoluteString, "http://test.com/api/model/posts?userId=myId")
        XCTAssertEqual(TestRouter.test.url(for: .test).absoluteString, "http://test.com/test")
    }
    
    func testRouterMethod() {
        XCTAssertEqual(Router.me.route.method, .get)
    }
    
}
