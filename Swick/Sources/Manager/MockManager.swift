//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public protocol MockManager {
    func call<Args, ReturnType>(functionId functionId: String, args: Args) throws -> ReturnType
    
    func verify() -> VerificationResult
    
    func addStub<Args>(
        functionId functionId: String,
        closure: (Any) -> Any,
        matcher: FunctionalMatcher<Args>
    )
    
    func addExpecatation<Args>(
        functionId functionId: String,
        fileLine: FileLine,
        times: FunctionalMatcher<UInt>,
        matcher: FunctionalMatcher<Args>
    )
}