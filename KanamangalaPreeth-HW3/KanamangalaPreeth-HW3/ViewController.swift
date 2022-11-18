//
//  ViewController.swift
//  KanamangalaPreeth-HW3
//
// Project: KanamangalaPreeth-HW3
// EID: PK9297
// Course: CS371L
//

import UIKit

// protocol for changing text
protocol TextChanger {
    func changeText(newText:String)
}

// protocol for changing color
protocol ColorChanger {
    func changeColor(newColor:UIColor)
}

class ViewController: UIViewController, TextChanger, ColorChanger {
    
    // the text label that shows on the main screen
    @IBOutlet weak var mainText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainText.text = "Text goes here"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the change text button is clicked, segue into the text view controller and pass in the current text
        if segue.identifier == "TextSegue",
           let nextVC = segue.destination as? TextViewController {
            nextVC.delegate = self
            nextVC.currentText = mainText.text!
        }
        
        // if the change color button is clicked, segue into the color view controller
        if segue.identifier == "ColorSegue",
           let nextVC = segue.destination as? ColorViewController {
            nextVC.delegate = self
        }
        
    }
    
    // set the main screen text to the text passed in as input
    func changeText(newText newName: String) {
        mainText.text = newName
    }
    
    // set the main screen text background color to the color passed in as input
    func changeColor(newColor: UIColor) {
        mainText.backgroundColor = newColor
    }
    
}

