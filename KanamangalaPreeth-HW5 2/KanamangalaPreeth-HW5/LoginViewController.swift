//
//  LoginViewController.swift
//  KanamangalaPreeth-HW5
//
// Project: KanamangalaPreeth-HW6
// EID: PK9297
// Course: CS371L
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    @IBOutlet weak var confirmPassLabel: UILabel!
    @IBOutlet weak var confirmPassField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a listener for detecting authentication changes
        // if a user is logged in, automatically segue to the main VC, otherwise only segue when the user logs in/signs up on the login VC
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.emailField.text = nil
                self.passwordField.text = nil
            }
        }
    }
    
    // segemented VC that hides/reveals fields and buttons based on whether the user is logging in or signing up
    @IBAction func selectAuthType(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            confirmPassLabel.isHidden = true
            confirmPassField.isHidden = true
            signInButton.isHidden = false
            signUpButton.isHidden = true
        case 1:
            confirmPassLabel.isHidden = false
            confirmPassField.isHidden = false
            signInButton.isHidden = true
            signUpButton.isHidden = false
        default:
            print("Cannot be reached")
        }
    }
    
    // when the login button is pressed, use firebase auth to log in (if valid) using the input email and pass
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!,
                           password: passwordField.text!) {
            authResult, error in
            if let error = error as NSError? {
                self.errorMessage.isHidden = false
                self.errorMessage.text = "\(error.localizedDescription)"
            } else {
                self.errorMessage.isHidden = true
                self.errorMessage.text = ""
            }
        }
    }
    
    // when the sign up button is pressed, use the firebase auth to create a user (if valid) using the input email and pass, and log in
    @IBAction func signupButtonPressed(_ sender: Any) {
        if passwordField.text != confirmPassField.text {
            errorMessage.isHidden = false
            errorMessage.text = "Passwords must match"
        } else {
            Auth.auth().createUser(withEmail: emailField.text!,
                                   password: passwordField.text!) {
                authResult, error in
                if let error = error as NSError? {
                    self.errorMessage.isHidden = false
                    self.errorMessage.text = "\(error.localizedDescription)"
                } else {
                    self.errorMessage.isHidden = true
                    self.errorMessage.text = ""
                }
            }
        }
    }
}
