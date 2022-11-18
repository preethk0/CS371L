//
//  ColorViewController.swift
//  KanamangalaPreeth-HW3
//
// Project: KanamangalaPreeth-HW3
// EID: PK9297
// Course: CS371L
//

import UIKit

class ColorViewController: UIViewController {
    
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // when the blue button is pressed, pass in the UIColor blue into the change color fxn of the main vc
    @IBAction func bluePressed(_ sender: Any) {
        let otherVC = delegate as! ColorChanger
        otherVC.changeColor(newColor: UIColor.blue)
        self.dismiss(animated: true, completion: nil)
    }
    
    // when the red button is pressed, pass in the UIColor red into the change color fxn of the main vc
    @IBAction func redPressed(_ sender: Any) {
        let otherVC = delegate as! ColorChanger
        otherVC.changeColor(newColor: UIColor.red)
        self.dismiss(animated: true, completion: nil)
    }
}
