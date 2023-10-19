//
//  RunnerUITests.swift
//  RunnerUITests
//
//  Created by Mia Brunal on 2023/10/19.
//

import XCTest

final class RunnerUITests: XCTestCase {
    func testAccessibilityAudits() throws {
        let app = XCUIApplication()
        app.launch()

        if #available(iOS 17.0, *) {
            try app.performAccessibilityAudit()
        } else {
            // Fallback on earlier versions
        }
    }
}
