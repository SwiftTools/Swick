public protocol ExpectationBuilder {
    init(mockManager: MockManager, times: FunctionalMatcher<UInt>, fileLine: FileLine)
}