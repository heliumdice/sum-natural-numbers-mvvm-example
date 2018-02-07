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
    
    private var dataModel = DataModel()
    
    // Getters
    var firstNumber : String {
        return dataModel.firstNumber
    }
    var secondNumber : String {
        return dataModel.secondNumber
    }
    
    init(dataModel : DataModel = DataModel()) {
        self.dataModel = dataModel
    }
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
            return .Invalid("The first number entered is not a natural number. A natural numbers is any positive integer.")
        }
        
        if !dataModel.secondNumber.isNumber  {
            return .Invalid("The second number entered is not a natural number. A natural numbers is any positive integer.")
        }
        
        return .Valid
    }
}

extension String  {
    struct NumFormatter {
        static let instance = NumberFormatter()
    }
    
    var doubleValue: Double? {
        return NumFormatter.instance.number(from: self)?.doubleValue
    }
    
    var integerValue: Int? {
        return NumFormatter.instance.number(from: self)?.intValue
    }

    public var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
