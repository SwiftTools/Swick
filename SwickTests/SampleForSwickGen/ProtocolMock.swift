//
//  ProtocolMock.swift
//  Swick
//
//  Created by Artyom Y. Razinov on 3/6/16.
//  Copyright © 2016 Artyom Y. Razinov. All rights reserved.
//

import Swick

protocol Protocol {
    func routine(_ a: String, b: Int) -> Int
}

class ProtocolMock: Protocol, MockType {
    let mockManager: Swick.MockManager
    
    class StubBuilder: Swick.StubBuilder {
        fileprivate let mockManager: Swick.MockManager
        
        required init(mockManager: Swick.MockManager) {
            self.mockManager = mockManager
        }
        
        func routine<A1: Swick.Matcher, A2: Swick.Matcher>(_ a: A1, b: A2) -> Swick.StubForFunctionBuilder<(String, Int), Int> where A1.MatchingType == String, A2.MatchingType == Int {
            let matcher = Swick.FunctionalMatcher<(String, Int)>(matchingFunction: { (args: (String, Int)) -> Bool in
                return a.valueIsMatching(args.0) && b.valueIsMatching(args.1)
            })
            return Swick.StubForFunctionBuilder<(String, Int), Int>(
                functionId: "0",
                mockManager: mockManager,
                matcher: matcher
            )
        }
    }
    
    class ExpectationBuilder: Swick.ExpectationBuilder {
        fileprivate let mockManager: Swick.MockManager
        fileprivate let times: Swick.FunctionalMatcher<UInt>
        fileprivate let fileLine: Swick.FileLine
        
        required init(mockManager: Swick.MockManager, times: Swick.FunctionalMatcher<UInt>, fileLine: Swick.FileLine) {
            self.mockManager = mockManager
            self.times = times
            self.fileLine = fileLine
        }
        
        func routine<A1: Swick.Matcher, A2: Swick.Matcher>(_ a: A1, b: A2) -> Void where A1.MatchingType == String, A2.MatchingType == Int {
            let matcher = Swick.FunctionalMatcher<(String, Int)>(matchingFunction: { (args: (String, Int)) -> Bool in
                return a.valueIsMatching(args.0) && b.valueIsMatching(args.1)
            })
            mockManager.addExpecatation(
                functionId: "0",
                fileLine: fileLine,
                times: times,
                matcher: matcher
            )
        }
    }
    
    init(mockManager: Swick.MockManager) {
        self.mockManager = mockManager
    }
    
    convenience init(file: StaticString = #file, line: UInt = #line) {
        self.init(mockManager: Swick.SwickMockManager(fileLine: Swick.FileLine(file: file, line: line)))
    }
    
    func routine(_ a: String, b: Int) -> Int {
        return try! mockManager.call(functionId: "0", args: (a, b))
    }
}
