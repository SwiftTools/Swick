//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public struct FileLine {
    public init(file: StaticString, line: UInt) {
        self.file = file
        self.line = line
    }
    
    public var file: StaticString
    public var line: UInt
}