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

    func testEcho() throws {
        
        let result = try Task.run("echo", "hello world")
        XCTAssertEqual(result.code, 0)
        XCTAssertEqual(result.stderr, "")
        XCTAssertEqual(result.stdout, "hello world")
    }
    
    func testEchoFail() throws {
        
        let result = try Task.run("printf")
        XCTAssertFalse(result.stderr.isEmpty)
        XCTAssertEqual(result.stdout, "")
    }
}

extension TasksTests {
    static var allTests: [(String, (TasksTests) -> () throws -> Void)] {
        return [
            ("testEcho", testEcho),
            ("testEchoFail", testEchoFail),
        ]
    }
}
