//
//  TasksTests.swift
//  Tasks
//
//  Created by Honza Dvorsky on 5/8/16.
//
//

@testable import Tasks
import XCTest

class TasksTests: XCTestCase {

    func testSuccess() throws {
        let result = try Task.run("echo", "hello world")
        XCTAssertEqual(result.code, 0)
        XCTAssertEqual(result.stderrStringUTF8, "")
        XCTAssertEqual(result.stdoutStringUTF8, "hello world")
    }
    
    func testFail() throws {
        let result = try Task.run("printf")
        XCTAssert(result.code != 0)
        XCTAssertFalse(result.stderrStringUTF8.isEmpty)
        XCTAssertEqual(result.stdoutStringUTF8, "")
    }
}

extension TasksTests {
    static var allTests: [(String, (TasksTests) -> () throws -> Void)] {
        return [
            ("testSuccess", testSuccess),
            ("testFail", testFail),
        ]
    }
}
