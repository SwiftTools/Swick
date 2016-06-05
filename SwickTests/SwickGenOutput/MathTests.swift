import XCTest
import Quick
import Nimble
import Swick

class MathTests: XCTestCase {
    func testExample() {
        let mathMock = MathMock()
        
        mathMock
            .stub()
            .sum(any(), b: any())
            .thenInvoke { (a, b) -> Int in return a + b }
        
        mathMock
            .stub()
            .sum(2, b: any())
            .thenInvoke { (a, b) -> Int in return b }
        
        mathMock
            .stub()
            .sum(2, b: 2)
            .thenReturn(5)
        
        expect(mathMock.sum(1, b: 1)).to(equal(2))
        expect(mathMock.sum(2, b: 1)).to(equal(1))
        expect(mathMock.sum(2, b: 2)).to(equal(5))
        
        // Before expectation
        mathMock.sum(41, b: 41)
        mathMock.expect().sum(41, b: 41)
        
        // After expectation
        mathMock.expect().sum(42, b: 42)
        mathMock.sum(42, b: 42)
        
        mathMock.verify()
        
        expect(mathMock.sum(2, b: 2)).to(equal(5))
    }
}
