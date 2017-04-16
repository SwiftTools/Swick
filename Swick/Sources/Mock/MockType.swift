public protocol MockType {
    var mockManager: MockManager { get }
    
    associatedtype StubBuilder
    associatedtype ExpectationBuilder
}

public extension MockType where StubBuilder: Swick.StubBuilder, ExpectationBuilder: Swick.ExpectationBuilder {
    func expect(file: StaticString = #file, line: UInt = #line) -> ExpectationBuilder {
        return ExpectationBuilder.init(
            mockManager: mockManager,
            times: Swick.atLeast(1),
            fileLine: Swick.FileLine(file: file, line: line)
        )
    }
    
    func expect<T: Matcher>(times: T, file: StaticString = #file, line: UInt = #line) -> ExpectationBuilder where T.MatchingType == UInt {
        return ExpectationBuilder.init(
            mockManager: mockManager,
            times: Swick.FunctionalMatcher(matcher: times),
            fileLine: Swick.FileLine(file: file, line: line)
        )
    }
    
    
    func stub() -> StubBuilder {
        return StubBuilder.init(mockManager: mockManager)
    }
    
    @discardableResult
    func verify() -> SwickVoid {
        let _ = mockManager.verify()
        return Swick.SwickVoid()
    }
}
