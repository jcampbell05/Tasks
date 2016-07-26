//
//  Tasks.swift
//  Tasks
//
//  Created by Honza Dvorsky on 5/8/16.
//
//

import Foundation

public struct TaskResult {
    public let code: Int32
    public let stdout: String
    public let stderr: String
}

public struct Task {
    
    public static func run(_ args: String...) throws -> TaskResult {
        return try run(args)
    }
    
    public static func run(_ args: [String], pwd: String? = nil, inheritEnvironment: Bool = true) throws -> TaskResult {
        
        let task = Foundation.Task()
        
        var args = args
        
        if let pwd = pwd {
            task.currentDirectoryPath = pwd
        }
        
        #if os(Linux)
        let processInfo = ProcessInfo.processInfo()
        #else
        let processInfo = ProcessInfo.processInfo
        #endif
        task.environment = processInfo.environment
        task.launchPath = try which(args.removeFirst())
        task.arguments = args
        
        let stdout = Pipe()
        task.standardOutput = stdout
        let stdoutHandle = stdout.fileHandleForReading
        
        let stderr = Pipe()
        task.standardError = stderr
        let stderrHandle = stderr.fileHandleForReading
        
        task.launch()
        task.waitUntilExit()
        
        let stdoutString = (String(data: stdoutHandle.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "").trimRight()
        let stderrString = (String(data: stderrHandle.readDataToEndOfFile(), encoding: String.Encoding.utf8) ?? "").trimRight()
        
        let result = TaskResult(code: task.terminationStatus, stdout: stdoutString, stderr: stderrString)
        return result
    }
}

extension String {

    var isAbsolute: Bool { return self.hasPrefix("/") }
    
    func trimRight() -> String {
        let trimmableChars: Set<Character> = ["\n", "\r", "\t", " "]
        let count = characters.count
        var end: Int = count
        for (idx, char) in characters.reversed().enumerated() {
            if trimmableChars.contains(char) {
                end = count-idx-1
            } else {
                break
            }
        }
        let trimmed = self.substring(to: index(startIndex, offsetBy: end))
        return trimmed
    }
}

func which(_ tool: String) throws -> String {

    if tool.isAbsolute {
        return tool
    }
    let result = try Task.run("/bin/sh", "-c", "which \(tool)")
    guard result.code == 0 else { throw TaskError("Failed to find tool \"\(tool)\"") }
    let path = result.stdout
    return path
}

public struct TaskError: Error {

    public let description: String
    init(_ description: String) {
        self.description = description
    }
}


