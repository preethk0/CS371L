//
//  PizzaViewController.swift
//  KanamangalaPreeth-HW5
//
// Project: KanamangalaPreeth-HW6
// EID: PK9297
// Course: CS371L
//

import UIKit

class PizzaViewController: UIViewController {
    
    @IBOutlet weak var segControl: UISegmentedControl!
    
    // local variables to store user choices of all the alert prompts
    // these are set every time the user clicks the respective alert
    var delegate: UIViewController!
    var size: String = "Small"
    var crust: String = ""
    var cheese: String = ""
    var meat: String = ""
    var veggies: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // user can select size via segmeneted control
    @IBAction func selectSize(_ sender: Any) {
        switch segControl.selectedSegmentIndex {
        case 0:
            self.size = "Small"
        case 1:
            self.size = "Medium"
        case 2:
            self.size = "Large"
        default:
            print("Cannot be reached")
        }
    }
    
    // user can select crust via default alert
    @IBAction func selectCrust(_ sender: Any) {
        let controller = UIAlertController(
            title: "Select crust",
            message: "Choose a crust type:",
            preferredStyle: .alert)
        
        controller.addAction(UIAlertAction(title: "Thin crust", style: .default, handler: { _ in
            self.crust = "Thin crust"
        }))
        controller.addAction(UIAlertAction(title: "Thick crust", style: .default, handler: { _ in
            self.crust = "Thick crust"
        }))
        
        present(controller, animated: true, completion: nil)
        
    }
    
    // user can select cheese via action sheet alert
    @IBAction func selectCheese(_ sender: Any) {
        let controller = UIAlertController(title: "Select cheese", message: "Choose a cheese type:", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Regular cheese", style: .default, handler: { _ in
            self.cheese = "Regular cheese"
        }))
        controller.addAction(UIAlertAction(title: "No cheese", style: .default, handler: { _ in
            self.cheese = "No cheese"
        } ))
        controller.addAction(UIAlertAction(title: "Double cheese", style: .default, handler: { _ in
            self.cheese = "Double cheese"
        } ))
        
        present(controller, animated: true, completion: nil)
    }
    
    // user can select meat via action sheet alert
    @IBAction func selectMeat(_ sender: Any) {
        let controller = UIAlertController(title: "Select meat", message: "Choose one meat:", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Pepperoni", style: .default, handler: { _ in
            self.meat = "Pepperoni"
        } ))
        controller.addAction(UIAlertAction(title: "Sausage", style: .default, handler: { _ in
            self.meat = "Sausage"
        } ))
        controller.addAction(UIAlertAction(title: "Canadian Bacon", style: .default, handler: { _ in
            self.meat = "Canadian Bacon"
        } ))
        
        present(controller, animated: true, completion: nil)
    }
    
    // user can select veggies via action sheet alert
    @IBAction func selectVeggies(_ sender: Any) {
        let controller = UIAlertController(title: "Select veggies", message: "Choose your veggies:", preferredStyle: .actionSheet)
        
        controller.addAction(UIAlertAction(title: "Mushroom", style: .default, handler: { _ in
            self.veggies = "Mushroom"
        } ))
        controller.addAction(UIAlertAction(title: "Onion", style: .default, handler: { _ in
            self.veggies = "Onion"
        } ))
        controller.addAction(UIAlertAction(title: "Green Olive", style: .default, handler: { _ in
            self.veggies = "Green Olive"
        } ))
        controller.addAction(UIAlertAction(title: "Black Olive", style: .default, handler: { _ in
            self.veggies = "Black Olive"
        } ))
        controller.addAction(UIAlertAction(title: "None", style: .default, handler: { _ in
            self.veggies = "None"
        } ))
        
        present(controller, animated: true, completion: nil)
    }
    
    // when the done button is pressed, check if any of the local variables have not been set,
    // if so, throw an alert for the missing component, if not, create a new pizza and call
    // addPizza onto the main VC
    @IBAction func donePressed(_ sender: Any) {
        var missingType = ""
        
        if crust == "" {
            missingType = "crust"
        } else if cheese == "" {
            missingType = "cheese"
        } else if meat == "" {
            missingType = "meat"
        } else if veggies == "" {
            missingType = "veggies"
        }
        
        if missingType == "" {
            let otherVC = delegate as! PizzaModifier
            let pizza = Pizza(size: size, crust: crust, cheese: cheese, meat: meat, veggies: veggies)
            otherVC.addPizza(newPizza: pizza)
            self.dismiss(animated: false, completion: nil)
        } else {
            let controller = UIAlertController(
                title: "Missing ingredient",
                message: "Please select a " + missingType + " type.",
                preferredStyle: .alert)
            
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
        }
    }
}
