//
//  MathEngine.swift
//  RPNCalculatorTests
//
//  Created by Samuel Goodwin on 4/3/21.
//

import XCTest
@testable import RPNCalculator

class MathEngineTests: XCTestCase {
    let engine = MathEngine()

    func testBasicAddition() {
        XCTAssertEqual(engine.parse("2 1 +"), 3.0)
    }

    func testBasicSubtraction() {
        XCTAssertEqual(engine.parse("2 1 -"), 1.0)
    }

    func testBasicMultiplication() {
        XCTAssertEqual(engine.parse("2 1 *"), 2.0)
    }

    func testBasicDivision() {
        XCTAssertEqual(engine.parse("8 2 /"), 4.0)
    }

    func testBasicPowers() {
        XCTAssertEqual(engine.parse("2 3 ^"), 8.0)
    }

    func testMoreComplicatedExamples() {
        let value = engine.parse("3 4 2 * 1 5 - 2 3 ^ ^ / +")

        XCTAssertEqual(value, 3.0001220703125)
    }
}
