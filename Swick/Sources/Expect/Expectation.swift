//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

struct Expectation {
    var matcher: FunctionalMatcher<Any>
    var times: FunctionalMatcher<UInt>
    var fileLine: FileLine
}