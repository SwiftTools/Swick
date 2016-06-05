import Swick

class MathMock: Math, MockType {
    let mockManager: Swick.MockManager
    
    class StubBuilder: Swick.StubBuilder {
        private let mockManager: Swick.MockManager
        
        required init(mockManager: Swick.MockManager) {
            self.mockManager = mockManager
        }
        
        func sum<A0: Swick.Matcher, A1: Swick.Matcher where A0.MatchingType == Int, A1.MatchingType == Int>(a0: A0, b a1: A1) -> Swick.StubForFunctionBuilder<(Int, Int), Int> {
            let matcher = Swick.FunctionalMatcher<(Int, Int)>(matchingFunction: { (args: (Int, Int)) -> Bool in
                return a0.valueIsMatching(args.0) && a1.valueIsMatching(args.1)
            })
            return Swick.StubForFunctionBuilder<(Int, Int), Int>(
                functionId: "sum(a0: Int, b a1: Int)->Int",
                mockManager: mockManager,
                matcher: matcher
            )
        }
        
    }
    
    class ExpectationBuilder: Swick.ExpectationBuilder {
        private let mockManager: Swick.MockManager
        private let times: Swick.FunctionalMatcher<UInt>
        private let fileLine: Swick.FileLine
        
        required init(mockManager: Swick.MockManager, times: Swick.FunctionalMatcher<UInt>, fileLine: Swick.FileLine) {
            self.mockManager = mockManager
            self.times = times
            self.fileLine = fileLine
        }
        
        func sum<A0: Swick.Matcher, A1: Swick.Matcher where A0.MatchingType == Int, A1.MatchingType == Int>(a0: A0, b a1: A1) {
            let matcher = Swick.FunctionalMatcher<(Int, Int)>(matchingFunction: { (args: (Int, Int)) -> Bool in
                return a0.valueIsMatching(args.0) && a1.valueIsMatching(args.1)
            })
            
            mockManager.addExpecatation(
                functionId: "sum(a0: Int, b a1: Int)->Int",
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
    
    func sum(a0: Int, b a1: Int) -> Int {
        return try! mockManager.call(functionId: "sum(a0: Int, b a1: Int)->Int", args: (a0, a1))
    }
    
}