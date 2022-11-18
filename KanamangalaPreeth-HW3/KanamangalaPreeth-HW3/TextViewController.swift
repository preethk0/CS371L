//
//  TextViewController.swift
//  KanamangalaPreeth-HW3
//
// Project: KanamangalaPreeth-HW3
// EID: PK9297
// Course: CS371L
//

import UIKit

class TextViewController: UIViewController {
    
    // text field shown on screen
    @IBOutlet weak var textField: UITextField!
    
    var delegate: UIViewController!
    var currentText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // keep the current text on the main screen as the prefilled input
        textField.text = currentText
    }
    
    // when save button is pressed, pass in the new user input into the change text fxn of the main VC
    @IBAction func savePressed(_ sender: Any) {
        let otherVC = delegate as! TextChanger
        otherVC.changeText(newText: textField.text!)
        self.dismiss(animated: true, completion: nil)
    }
    
}
