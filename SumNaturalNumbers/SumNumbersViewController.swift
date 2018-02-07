//
//  ViewController.swift
//  SumNaturalNumbers
//
//  Created by Richard Flanagan on 05/02/2018.
//  Copyright © 2018 richardflanagan. All rights reserved.
//

import UIKit

class SumNumbersViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstNumTxtField: UITextField!
    @IBOutlet weak var secondNumTxtField: UITextField!
    @IBOutlet weak var sumButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: Actions
extension SumNumbersViewController {
    @IBAction func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func sumNumbers() {
        dismissKeyboard()
        
        switch viewModel.validate() {
        case .Valid:
            resultLabel.text = viewModel.sumNumbers()
        case .Invalid(let error):
            showErrorAlert(input: error)
        }
    }
}

// MARK: UITextFieldDelegate
extension SumNumbersViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if textField == firstNumTxtField {
            viewModel.updateFirstNumber(number: newString)
        } else if textField == secondNumTxtField {
            viewModel.updateSecondNumber(number: newString)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNumTxtField {
            secondNumTxtField.becomeFirstResponder()
        } else {
            sumNumbers()
        }
        return true
    }
}

// MARK: Private Methods
private extension SumNumbersViewController {
    func showErrorAlert(input: String) {
        let alertController = UIAlertController(title: "Error", message: input, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel) { action in }
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true) {}
    }
}
