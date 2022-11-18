//
//  CalculatorViewController.swift
//  KanamangalaPreeth-HW4
//
// Project: KanamangalaPreeth-HW4
// EID: PK9297
// Course: CS371L
//

import UIKit

class CalculatorViewController: UIViewController {

    // outlets for both the operands, the operator sign, and result
    @IBOutlet weak var operandOne: UITextField!
    @IBOutlet weak var operandTwo: UITextField!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var operatorSign: UILabel!
    
    var operation = ""
    
    // the original VC passes the operation of the row clicked, and we translate it to a sign
    override func viewDidLoad() {
        super.viewDidLoad()

        if operation == "Add" {
            operatorSign.text = "+"
        } else if operation == "Subtract" {
            operatorSign.text = "-"
        } else if operation == "Multiply" {
            operatorSign.text = "*"
        } else {
            operatorSign.text = "/"
        }
    }
    
    // when the calculate button is pressed, first check if two inputs are entered
    // then, preform the operation with the two inputs consistent with the operation sign and set the result value
    @IBAction func calculatePressed(_ sender: Any) {
        if operandOne.text!.isEmpty || operandTwo.text!.isEmpty {
            result.text = "Please enter two operands"
        }
        
        let valueOne = Float(operandOne.text!)!
        let valueTwo = Float(operandTwo.text!)!
        
        if operation == "Add" {
            result.text = String(valueOne + valueTwo)
        } else if operation == "Subtract" {
            result.text = String(valueOne - valueTwo)
        } else if operation == "Multiply" {
            result.text = String(valueOne * valueTwo)
        } else {
            result.text = String(valueOne / valueTwo)
        }
    }
    
}
