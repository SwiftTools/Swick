import Swick

class MathMock:
    Math,
    MockType
{
    let mockManager: Swick.MockManager

    class StubBuilder: Swick.StubBuilder {
        private let mockManager: Swick.MockManager

        required init(mockManager: Swick.MockManager) {
            self.mockManager = mockManager
        }

        func sum<A1: Swick.Matcher, A2: Swick.Matcher>(
            _ a1: A1,
            b a2: A2)
            -> Swick.StubForFunctionBuilder<(Int, Int), Int>
            where
            A1.MatchingType == Int,
            A2.MatchingType == Int
        {
            let matcher = Swick.FunctionalMatcher<(Int, Int)>(
                matchingFunction: { (b1: Int, b2: Int) -> Bool in
                    return a1.valueIsMatching(b1) && a2.valueIsMatching(b2)
                }
            )

            return Swick.StubForFunctionBuilder<(Int, Int), Int>(
                functionId: "sum(_ a: Int, b: Int)",
                mockManager: mockManager,
                matcher: matcher
            )
        }
    }

    class ExpectationBuilder: Swick.ExpectationBuilder {
        private let mockManager: Swick.MockManager
        private let times: Swick.FunctionalMatcher<UInt>
        private let fileLine: Swick.FileLine

        required init(
            mockManager: Swick.MockManager,
            times: Swick.FunctionalMatcher<UInt>,
            fileLine: Swick.FileLine)
        {
            self.mockManager = mockManager
            self.times = times
            self.fileLine = fileLine
        }

        func sum<A1: Swick.Matcher, A2: Swick.Matcher>(
            _ a1: A1,
            b a2: A2)
            where
            A1.MatchingType == Int,
            A2.MatchingType == Int
        {
            let matcher = Swick.FunctionalMatcher<(Int, Int)>(
                matchingFunction: { (b1: Int, b2: Int) -> Bool in
                    return a1.valueIsMatching(b1) && a2.valueIsMatching(b2)
                }
            )

            mockManager.addExpecatation(
                functionId: "sum(_ a: Int, b: Int)",
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
        self.init(
            mockManager: Swick.SwickMockManager(
                fileLine: Swick.FileLine(
                    file: file,
                    line: line
                )
            )
        )
    }

    func sum(
        _ a1: Int,
        b a2: Int)
        -> Int
    {
        return try! mockManager.call(
            functionId: "sum(_ a: Int, b: Int)",
            args: (
                a1,
                a2
            )
        )
    }
}
