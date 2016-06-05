//
//  SwickNewTests.swift
//  Swick
//
//  Created by Artyom Y. Razinov on 3/8/16.
//  Copyright © 2016 Artyom Y. Razinov. All rights reserved.
//

import XCTest

import Quick
import Nimble
import Swick

class SwickNewTests: XCTestCase {
    func testExample() {
        let protocolMock = ProtocolMock()
        
        protocolMock
            .stub()
            .routine(any(), b: any())
            .thenInvoke { (a, b) -> Int in return (Int(a) ?? 0) + b }
        
        protocolMock
            .stub()
            .routine("1", b: 1)
            .thenReturn(1)
        
        protocolMock
            .stub()
            .routine("1", b: 2)
            .thenReturn(2)
        
        expect(protocolMock.routine("1", b: 1)).to(equal(1))
        expect(protocolMock.routine("10", b: 5)).to(equal(15))
        
        // Before expectation
        protocolMock.routine("1", b: 41)
        protocolMock.expect().routine("1", b: 41)
        
        // After expectation
        protocolMock.expect().routine("1", b: 42)
        protocolMock.routine("1", b: 42)
        
        protocolMock.verify()
        
        expect(protocolMock.routine("1", b: 2)).to(equal(2))
    }
}
