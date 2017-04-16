//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public struct FunctionalMatcher<T>: Matcher {
    public typealias MatchingType = T
    
    private let matchingFunction: (T) -> Bool
    
    public init(matchingFunction: @escaping (T) -> Bool) {
        self.matchingFunction = matchingFunction
    }
    
    public init<U: Matcher>(matcher: U) where U.MatchingType == T {
        self.matchingFunction = matcher.valueIsMatching
    }
    
    public func valueIsMatching(_ value: MatchingType) -> Bool {
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

public func equals<T>(_ value: T) -> FunctionalMatcher<T> where T: Equatable {
    return FunctionalMatcher<T> { other in value == other }
}

public func isSame<T>(_ value: T) -> FunctionalMatcher<T> where T: AnyObject {
    return FunctionalMatcher<T> { other in value === other }
}

public func atLeast<T>(_ atLeast: T) -> FunctionalMatcher<T> where T: Comparable {
    return FunctionalMatcher<T> { given in given >= atLeast }
}

public func atMost<T>(_ atLeast: T) -> FunctionalMatcher<T> where T: Comparable {
    return FunctionalMatcher<T> { given in given <= atLeast }
}
