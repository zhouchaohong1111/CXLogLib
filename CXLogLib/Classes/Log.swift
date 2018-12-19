//
//  Log.swift
//  LogSystem
//
//  Created by 周超红 on 2018/12/13.
//  Copyright © 2018 Chaohong Team. All rights reserved.
//

import Foundation
import XCGLogger

/**
 日志类
 提供  verbose debug info warning error 方法
 使用示例：
 Log.info("some info")
 Log.info("tag", "some info")
 */

public struct Log {
    
    static func filterLog(includeFrom tags: Array<String>) {
        xcgLog.filters = [TagFilter(includeFrom: tags)]
    }
    
    static private var enableDebug = false
    
    static func enableDebugLog() {
        enableDebug = true
        
        #if !DEBUG
        xcgLog.outputLevel = .debug
        #endif
    }
    
    static func disableDebugLog() {
        enableDebug = false
        #if !DEBUG
        xcgLog.outputLevel = .info
        #endif
    }
    
    fileprivate static var xcgLog : XCGLogger = {
        //        let log = XCGLogger.default
        
        let log = XCGLogger(identifier: "advLogger", includeDefaultDestinations: true)
        
        let enableDebug = false //允许客户端控制
        var level = XCGLogger.Level.verbose
        #if DEBUG
        level = .verbose
        #else
        level = .info
        #endif
        
        log.setup(level: level, showLogIdentifier: false, showFunctionName: true, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, showDate: true, writeToFile: nil, fileLevel: nil)
        
        return log
    }()
    
    private static var defautTag : String = {
        let appName = getAppName()
        
        let index = appName.index(appName.startIndex, offsetBy: 5)
        let tag = String(appName[..<index])
        return tag
    }();
    
    
    
    private static func getAppName() -> String {
        let infoDictionary = Bundle.main.infoDictionary!
        let appDisplayName = infoDictionary["CFBundleDisplayName"] //程序名称
        return appDisplayName as! String
    }
    
    //MARK Open Functions
    public static func verbose(_ msg: @autoclosure () -> Any?,
                               functionName: StaticString = #function,
                               fileName: StaticString = #file,
                               lineNumber: Int = #line) {
        xcgLog.verbose(msg, functionName: functionName, fileName : fileName, lineNumber : lineNumber )
    }
    
    public static func debug(_ msg: @autoclosure () -> Any?,
                             functionName: StaticString = #function,
                             fileName: StaticString = #file,
                             lineNumber: Int = #line) {
        xcgLog.debug(msg, functionName: functionName, fileName : fileName, lineNumber : lineNumber )
    }
    
    public static func info(_ msg: @autoclosure () -> Any?,
                            functionName: StaticString = #function,
                            fileName: StaticString = #file,
                            lineNumber: Int = #line) {
        xcgLog.info(msg, functionName: functionName, fileName : fileName, lineNumber : lineNumber )
    }
    
    public static func warning(_ msg: @autoclosure () -> Any?,
                               functionName: StaticString = #function,
                               fileName: StaticString = #file,
                               lineNumber: Int = #line) {
        xcgLog.warning(msg, functionName: functionName, fileName : fileName, lineNumber : lineNumber )
    }
    
    public static func error(_ msg: @autoclosure () -> Any?,
                             functionName: StaticString = #function,
                             fileName: StaticString = #file,
                             lineNumber: Int = #line) {
        xcgLog.error(msg, functionName: functionName, fileName : fileName, lineNumber : lineNumber )
    }
    
    
    private static let tags = XCGLogger.Constants.userInfoKeyTags
    //    private static let tags = XCGLogger.Constants.userInfoKeyDevs
    
    //Mark withtag
    
    
    
    
    private static func logln(_ level: XCGLogger.Level = .debug, _ tag: String = "", functionName: StaticString = #function, fileName: StaticString = #file, lineNumber: Int = #line,  closure: @escaping () -> Any?) {
        let msg : () -> Any? = {
            guard let messge = closure() else { return nil }
            return " [\(tag)] " + String(describing: messge)
        }
        
        xcgLog.logln(.verbose, functionName: functionName, fileName: fileName, lineNumber: lineNumber, userInfo: [tags:tag], closure: msg)
    }
    
    public static func verbose(_ tag:String, _ msg: @autoclosure @escaping () -> Any?,
                               functionName: StaticString = #function,
                               fileName: StaticString = #file,
                               lineNumber: Int = #line) {
        logln(.verbose, tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: msg)
    }
    
    public static func debug(_ tag:String, _ msg: @autoclosure @escaping () -> Any?,
                             functionName: StaticString = #function,
                             fileName: StaticString = #file,
                             lineNumber: Int = #line) {
        logln(.debug, tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: msg)
    }
    
    public static func info(_ tag:String, _ msg: @autoclosure @escaping () -> Any?,
                            functionName: StaticString = #function,
                            fileName: StaticString = #file,
                            lineNumber: Int = #line) {
        logln(.info, tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: msg)
    }
    
    public static func warning(_ tag:String, _ msg: @autoclosure @escaping () -> Any?,
                               functionName: StaticString = #function,
                               fileName: StaticString = #file,
                               lineNumber: Int = #line) {
        logln(.warning, tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: msg)
    }
    
    public static func error(_ tag:String, _ msg: @autoclosure @escaping () -> Any?,
                             functionName: StaticString = #function,
                             fileName: StaticString = #file,
                             lineNumber: Int = #line) {
        logln(.error, tag, functionName: functionName, fileName: fileName, lineNumber: lineNumber, closure: msg)
    }
    
}


