//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public struct FailDescription {
    public init(message: String, fileLine: FileLine) {
        self.message = message
        self.fileLine = fileLine
    }
    
    public var message: String
    public var fileLine: FileLine
}