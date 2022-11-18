//  ViewController.swift
//  KanamangalaPreeth-HW2
//
// Project: KanamangalaPreeth-HW2
// EID: PK9297
// Course: CS371L

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        userField.delegate = self
        passwordField.delegate = self
    }
    
    // Called when the user clicks on the view outside of the UITextField
    func userFieldShouldReturn(userField:UITextField) -> Bool {
        userField.resignFirstResponder()
        return true
    }
    
    func passwordFieldShouldReturn(passwordField:UITextField) -> Bool {
        passwordField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Whenever the login button is pressed, we display a login message if both text fields are filled in
    // otherwise, an error status message is either field is not filled in
    @IBAction func loginPressed(_ sender: Any) {
        if ((userField.text!.isEmpty)) || (passwordField.text!.isEmpty) {
            statusField.text = "Invalid login"
        } else {
            let user = userField.text!
            statusField.text = user + " logged in."
        }
    }
}
