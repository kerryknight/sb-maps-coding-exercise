//
//  Logging.swift
//
//  Created by Kerry Knight on 03Apr2018.
//  Copyright © 2018 Kerry Knight, Inc. All rights reserved.
//

import Foundation
import XCGLogger

let log: XCGLogger = {
	let log = XCGLogger.default
    log.setup(level: .debug, showLogIdentifier: true, showThreadName: true, showLevel: false, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLevel: .debug)
    log.identifier = "SBLog" // use this for filtering on manually entered log statements
	
	return log
}()
