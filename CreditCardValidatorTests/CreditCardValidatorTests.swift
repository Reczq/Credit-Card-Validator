//
//  CreditCardValidatorTests.swift
//  CreditCardValidatorTests
//
//  Created by Dominik Reczek on 02/11/2017.
//  Copyright © 2017 Dominik Reczek. All rights reserved.
//

import XCTest
@testable import CreditCardValidator

class CreditCardValidatorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCreditCardGeneratorContainsSlash() {
        let generator = RandomCreditCardCodeGenerator()
        var generatedCode = generator.getFullCreditCardCodeWithSeparations()

        XCTAssert(generatedCode.range(of: "/") != nil, "contains slash")
    }

    func testGeneratedCodeHasAtLeastOneWhitespace() {
        let generator = RandomCreditCardCodeGenerator()
        var generatedCode = generator.getFullCreditCardCodeWithSeparations()

        XCTAssert(generatedCode.range(of: " ") != nil, "contains at least one whitespace")
    }

    func testDoesGeneratedCodeHas23Characters() {
        let generator = RandomCreditCardCodeGenerator()
        var generatedCode = generator.getFullCreditCardCode()

        XCTAssert(generatedCode.count == 23, "It contains 23 characters")
    }
}
