//
//  ViewModel.swift
//  SumNaturalNumbers
//
//  Created by Richard Flanagan on 05/02/2018.
//  Copyright © 2018 richardflanagan. All rights reserved.
//

import Foundation

enum NumberValidationState {
    case Valid
    case Invalid(String)
}

class ViewModel {
    
    private var dataModel = DataModel() {
        didSet {
            firstNumber.value = dataModel.firstNumber
            secondNumber.value = dataModel.secondNumber
        }
    }
    
    // Getters
    var firstNumber : Box<String> = Box("")
    var secondNumber : Box<String> = Box("")
}


extension ViewModel {
    // Setters
    func updateFirstNumber(number: String ) {
        dataModel.firstNumber = number
    }
    
    func updateSecondNumber(number: String) {
        dataModel.secondNumber = number
    }
    
    func sumNumbers() -> String {
        if let firstNum = UInt64(dataModel.firstNumber),
            let secondNum = UInt64(dataModel.secondNumber) {
            let sum = firstNum + secondNum
            return String(sum)
        }
        assert(false, "Error casting strings to UInt64")
        return String()
    }
}

// MARK: Validation
extension ViewModel {
    func validate() -> NumberValidationState {
        if dataModel.firstNumber.isEmpty || dataModel.secondNumber.isEmpty {
            return .Invalid("Please make sure you have entered two numbers.")
        }
        
        if !dataModel.firstNumber.isNumber {
            return .Invalid("The first number entered contains non-numeric characters. A natural numbers is any positive whole number.")
        }
        
        if !dataModel.secondNumber.isNumber  {
            return .Invalid("The second number entered contains non-numeric characters. A natural numbers is any positive integer.")
        }
        
        if let firstNum = UInt64(dataModel.firstNumber),
            let secondNum = UInt64(dataModel.secondNumber) {
            if firstNum < 0 || secondNum < 0 {
                return .Invalid("Numbers must be positive integers.")
            }
        }
        
        return .Valid
    }
}

extension String  {
    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
