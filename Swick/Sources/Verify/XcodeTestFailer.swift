//
//  XcodeTestFailer.swift
//  Swick
//
//  Created by Artyom Y. Razinov on 3/8/16.
//  Copyright © 2016 Artyom Y. Razinov. All rights reserved.
//

import XCTest

class XcodeTestFailer: Failer {
    func fail(failDescription: FailDescription) {
        XCTFail(failDescription.message, file: failDescription.fileLine.file, line: failDescription.fileLine.line)
    }
}