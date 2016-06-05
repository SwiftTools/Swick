//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public struct FunctionalMatcher<T>: Matcher {
    public typealias MatchingType = T
    
    private let matchingFunction: T -> Bool
    
    public init(matchingFunction: T -> Bool) {
        self.matchingFunction = matchingFunction
    }
    
    public init<U: Matcher where U.MatchingType == T>(matcher: U) {
        self.matchingFunction = matcher.valueIsMatching
    }
    
    public func valueIsMatching(value: MatchingType) -> Bool {
        return matchingFunction(value)
    }
}

extension FunctionalMatcher {
    func byStrippingType() -> FunctionalMatcher<Any> {
        return FunctionalMatcher<Any>(
            matchingFunction: { args in
                return self.valueIsMatching(args as! T)
            }
        )
    }
}

public func any<T>() -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { _ in return true }
}

public func none<T>() -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { _ in return false }
}

public func equals<T where T: Equatable>(value: T) -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { other in value == other }
}

public func isSame<T where T: AnyObject>(value: T) -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { other in value === other }
}

public func atLeast<T where T: Comparable>(atLeast: T) -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { given in given >= atLeast }
}

public func atMost<T where T: Comparable>(atLeast: T) -> FunctionalMatcher<T> {
    return FunctionalMatcher<T> { given in given <= atLeast }
}