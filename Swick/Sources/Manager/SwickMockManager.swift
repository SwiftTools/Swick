//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public class SwickMockManager: MockManager {
    private var stubs: [String: [Stub]] = [:]
    private var callRecords: [CallRecord] = []
    private var expectations: [String: [Expectation]] = [:]
    private let failer: Failer
    private let fileLine: FileLine
    
    public init(failer: Failer = XcodeTestFailer(), fileLine: FileLine) {
        self.failer = failer
        self.fileLine = fileLine
    }
    
    public func call<Args, ReturnType>(functionId functionId: String, args: Args) throws -> ReturnType {
        let callRecord = CallRecord(
            functionId: functionId,
            args: args
        )
        
        callRecords.append(callRecord)
        
        if let stubs = stubs[functionId] {
            for stub in stubs.reverse() {
                if stub.matcher.valueIsMatching(args) {
                    return stub.closure(args) as! ReturnType
                }
            }
        }
        
        throw SwickError.ResultWasNotStubbed
    }
    
    public func verify() -> VerificationResult {
        var fails = [FailDescription]()
        
        for (functionId, expectations) in self.expectations {
            for expectation in expectations {
                var timesCalled: UInt = 0
                for callRecord in callRecords {
                    if callRecord.functionId == functionId {
                        if expectation.matcher.valueIsMatching(callRecord.args) {
                            timesCalled += 1
                        }
                    }
                }
                
                if !expectation.times.valueIsMatching(timesCalled) {
                    let failDescription = FailDescription(
                        message: "Expectation was not fulfilled",
                        fileLine: expectation.fileLine
                    )
                    fails.append(failDescription)
                    failer.fail(failDescription)
                }
            }
        }
        
        if fails.count > 0 {
            return .Fail(fails)
        } else {
            return .Success
        }
    }
    
    public func addExpecatation<Args>(functionId functionId: String, fileLine: FileLine, times: FunctionalMatcher<UInt>, matcher: FunctionalMatcher<Args>) {
        let expectation = Expectation(
            matcher: matcher.byStrippingType(),
            times: times,
            fileLine: fileLine
        )
        addExpectation(expectation, functionId: functionId)
    }
    
    public func addStub<Args>(functionId functionId: String, closure: (Any) -> Any, matcher: FunctionalMatcher<Args>) {
        let stub = Stub(
            closure: closure,
            matcher: matcher.byStrippingType()
        )
        addStub(stub, functionId: functionId)
    }
    
    private func addStub(stub: Stub, functionId: String) {
        if stubs[functionId] != nil {
            stubs[functionId]?.append(stub)
        } else {
            stubs[functionId] = [stub]
        }
    }
    
    private func addExpectation(expectation: Expectation, functionId: String) {
        if expectations[functionId] != nil {
            expectations[functionId]?.append(expectation)
        } else {
            expectations[functionId] = [expectation]
        }
    }
}