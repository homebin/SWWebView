//
//  PromiseAssert.swift
//  hybrid
//
//  Created by alastair.coote on 28/07/2017.
//  Copyright © 2017 Guardian Mobile Innovation Lab. All rights reserved.
//

import Foundation
import PromiseKit
import XCTest

extension Promise {
    func assertResolves() {

        let expect = XCTestExpectation(description: "Promise resolves")
        let waiter = XCTWaiter()
        compactMap { (_) in
            expect.fulfill()
        }.catch { error in
            XCTFail("\(error)")
            expect.fulfill()
        }

        waiter.wait(for: [expect], timeout: 30)
    }

    func assertRejects() {

        let expect = XCTestExpectation(description: "Promise resolves")

        compactMap { _ in
        }.catch { _ in
            XCTAssertTrue(true, "Promise should reject")
            expect.fulfill()
        }

        let waiter = XCTWaiter()
        waiter.wait(for: [expect], timeout: 1)
    }
}
