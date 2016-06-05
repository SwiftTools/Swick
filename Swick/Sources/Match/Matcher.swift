//
// Copyright (c) 2016 Swick contributors
// This program is made available under the terms of the MIT License.
//

public protocol Matcher {
    associatedtype MatchingType
    func valueIsMatching(value: MatchingType) -> Bool
}

extension Equatable {
    public func valueIsMatching(value: Self) -> Bool {
        return self == value
    }
}

//extension AnyForwardCollection: Matcher {}
//extension AnyBidirectionalCollection: Matcher {}
//extension EmptyCollection: Matcher {}
//extension EmptyGenerator: Matcher {}
//extension EnumerateGenerator: Matcher {}
//extension EnumerateSequence: Matcher {}
//extension FlattenBidirectionalCollection: Matcher {}
//extension CollectionOfOne: Matcher {}
//extension ContiguousArray: Matcher {}
//extension Dictionary: Matcher {}
//extension DictionaryGenerator: Matcher {}
//extension AnyRandomAccessCollection: Matcher {}
//extension Array: Matcher {}
//extension ArraySlice: Matcher {}
//extension AnySequence: Matcher {}
//extension Array: Matcher {}
//extension ArraySlice: Matcher {}
//extension CVaListPointer: Matcher {}
//extension DictionaryLiteral: Matcher {}
//extension FlattenCollection: Matcher {}
//extension FlattenGenerator: Matcher {}
//extension FlattenSequence: Matcher {}
//extension GeneratorSequence: Matcher {}
//extension GeneratorOfOne: Matcher {}
//extension IndexingGenerator: Matcher {}
//extension JoinGenerator: Matcher {}
//extension JoinSequence: Matcher {}
//extension LazyCollection: Matcher {}
//extension LazyFilterCollection: Matcher {}
//extension LazyFilterGenerator: Matcher {}
//extension LazyFilterSequence: Matcher {}
//extension LazyMapCollection: Matcher {}
//extension LazyMapGenerator: Matcher {}
//extension LazyMapSequence: Matcher {}
//extension LazySequence: Matcher {}
//extension RangeGenerator: Matcher {}
//extension RawByte: Matcher {}
//extension Repeat: Matcher {}
//extension ReverseCollection: Matcher {}
//extension Mirror: Matcher {}
//extension MutableSlice: Matcher {}
//extension PermutationGenerator: Matcher {}
//extension ReverseRandomAccessCollection: Matcher {}
//extension SetGenerator: Matcher {}
//extension Slice: Matcher {}
//extension StaticString: Matcher {}
//extension StrideThrough: Matcher {}
//extension StrideThroughGenerator: Matcher {}
//extension StrideTo: Matcher {}
//extension StrideToGenerator: Matcher {}
//extension CharacterView: Matcher {}
//extension UnicodeScalarView: Matcher {}
//extension Index: Matcher {}
//extension Generator: Matcher {}
//extension UTF16View: Matcher {}
//extension Index: Matcher {}
//extension UTF8View: Matcher {}
//extension Index: Matcher {}
//extension Index: Matcher {}
//extension UTF16: Matcher {}
//extension UTF32: Matcher {}
//extension UTF8: Matcher {}
//extension UnsafeBufferPointerGenerator: Matcher {}
//extension UnsafeMutableBufferPointer: Matcher {}
//extension Unmanaged: Matcher {}
//extension UnsafeBufferPointer: Matcher {}
//extension Zip2Generator: Matcher {}
//extension Zip2Sequence: Matcher {}

extension AnyBidirectionalIndex: Matcher {}
extension AnyForwardIndex: Matcher {}
extension AnyRandomAccessIndex: Matcher {}
extension AutoreleasingUnsafeMutablePointer: Matcher {}
extension Bool: Matcher {}
extension COpaquePointer: Matcher {}
extension Character: Matcher {}
extension ClosedInterval: Matcher {}
extension DictionaryIndex: Matcher {}
extension Double: Matcher {}
extension FlattenBidirectionalCollectionIndex: Matcher {}
extension FlattenCollectionIndex: Matcher {}
extension Float: Matcher {}
extension Float80: Matcher {}
extension HalfOpenInterval: Matcher {}
extension Int: Matcher {}
extension Int16: Matcher {}
extension Int32: Matcher {}
extension Int64: Matcher {}
extension Int8: Matcher {}
extension LazyFilterIndex: Matcher {}
extension ManagedBufferPointer: Matcher {}
extension ObjectIdentifier: Matcher {}
extension Range: Matcher {}
extension ReverseIndex: Matcher {}
extension ReverseRandomAccessIndex: Matcher {}
extension Set: Matcher {}
extension SetIndex: Matcher {}
extension String: Matcher {}
extension UInt: Matcher {}
extension UInt16: Matcher {}
extension UInt32: Matcher {}
extension UInt64: Matcher {}
extension UInt8: Matcher {}
extension UnicodeScalar: Matcher {}
extension UnsafeMutablePointer: Matcher {}
extension UnsafePointer: Matcher {}