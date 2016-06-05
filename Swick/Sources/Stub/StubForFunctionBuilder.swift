//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public class StubForFunctionBuilder<Args, ReturnType> {
    private let mockManager: MockManager
    private var functionId: String
    private let matcher: FunctionalMatcher<Args>
    
    public init(functionId: String, mockManager: MockManager, matcher: FunctionalMatcher<Args>) {
        self.mockManager = mockManager
        self.functionId = functionId
        self.matcher = matcher
    }
    
    public func thenReturn(result: ReturnType) {
        mockManager.addStub(
            functionId: functionId,
            closure: { _ in return result },
            matcher: matcher.byStrippingType()
        )
    }
    
    public func thenInvoke(closure: Args -> ReturnType) {
        mockManager.addStub(
            functionId: functionId,
            closure: { any in return closure(any as! Args) },
            matcher: matcher.byStrippingType()
        )
    }
}
