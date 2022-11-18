//
//  AddTimerViewController.swift
//  KanamangalaPreeth-HW7
//
// Project: KanamangalaPreeth-HW7
// EID: PK9297
// Course: CS371L
//

import UIKit

class AddTimerViewController: UIViewController {

    var delegate: UIViewController!
    @IBOutlet weak var eventField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var timeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // when the save button is pressed, create a new timer object with values as the text field inputs and pass into the CreateTimer protocol
    @IBAction func savePressed(_ sender: Any) {
        let otherVC = delegate as! CreateTimer
        let timer = Timer(event: eventField.text!, location: locationField.text!, time: Int(timeField.text!)!)
        otherVC.addTimer(newTimer: timer)
        self.dismiss(animated: false, completion: nil)
    }
    
}
