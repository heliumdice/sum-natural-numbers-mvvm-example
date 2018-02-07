//
//  SumNaturalNumbersTests.swift
//  SumNaturalNumbersTests
//
//  Created by Richard Flanagan on 05/02/2018.
//  Copyright © 2018 richardflanagan. All rights reserved.
//

import XCTest
@testable import SumNaturalNumbers

class SumNaturalNumbersTests: XCTestCase {
    
    var validViewModel : ViewModel!
    
    override func setUp() {
        super.setUp()
        
        let dataModel = DataModel(firstNumber: "123", secondNumber: "123")
        validViewModel = ViewModel(dataModel: dataModel)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFirstNumber() {
        XCTAssertEqual(validViewModel.firstNumber, "123")
    }
    
    func testSecondNumber() {
        XCTAssertEqual(validViewModel.secondNumber, "123")
    }
    
    func testUpdateFirstNumber() {
        validViewModel.updateFirstNumber(number: "456")
        XCTAssertEqual(validViewModel.firstNumber, "456")
    }
    
    func testUpdateSecondNumber() {
        validViewModel.updateSecondNumber(number: "789")
        XCTAssertEqual(validViewModel.secondNumber, "789")
    }
    
    func testValidateMissingNumbers() {
        let invalidViewModel = ViewModel()
        let validation = invalidViewModel.validate()
        
        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "Please make sure you have entered two numbers.")
        } else {
            XCTAssert(false)
        }
    }
    
    func testFirstNumberNonNumber() {
        var invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "1w3", secondNumber: "123"))
        var validation = invalidViewModel.validate()
        
        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The first number entered is not a natural number. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
        
        invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "123", secondNumber: "abc"))
        validation = invalidViewModel.validate()
        
        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The second number entered is not a natural number. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
    }
    
    func testNegativeNumbers() {
        var invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "-123", secondNumber: "123"))
        var validation = invalidViewModel.validate()
        
        // Negative first number
        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The first number entered is not a natural number. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
        
        invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "123", secondNumber: "-123"))
        validation = invalidViewModel.validate()
        
        // Negative second number
        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The second number entered is not a natural number. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
    }
    
    func testNonIntegerNumbers() {
        var invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "123.456", secondNumber: "123"))
        var validation = invalidViewModel.validate()

        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The first number entered contains non-numeric characters. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
        
        invalidViewModel = ViewModel(dataModel: DataModel(firstNumber: "123", secondNumber: "123.456"))
        validation = invalidViewModel.validate()

        if case .Invalid(let message) = validation {
            XCTAssertEqual(message, "The second number entered contains non-numeric characters. A natural numbers is any positive integer.")
        } else {
            XCTAssert(false)
        }
    }
}
