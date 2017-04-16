//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public protocol MockManager {
    func call<Args, ReturnType>(functionId: String, args: Args) throws -> ReturnType
    
    func verify() -> VerificationResult
    
    func addStub<Args>(
        functionId: String,
        closure: @escaping (Any) -> Any,
        matcher: FunctionalMatcher<Args>
    )
    
    func addExpecatation<Args>(
        functionId: String,
        fileLine: FileLine,
        times: FunctionalMatcher<UInt>,
        matcher: FunctionalMatcher<Args>
    )
}
