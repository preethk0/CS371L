//
//  ViewController.swift
//  KanamangalaPreeth-HW5
//
// Project: KanamangalaPreeth-HW5
// EID: PK9297
// Course: CS371L
//

import UIKit

// pizza class to better store variables that the user chooses on the pizza view controller
class Pizza {
    var pizzaSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies:String
    
    init(size: String, crust: String, cheese: String, meat: String, veggies: String) {
        self.pizzaSize = size
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
}

// protocol that allows class to add a new pizza to the pizzalist
protocol PizzaModifier {
    func addPizza(newPizza: Pizza)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, PizzaModifier {
    
    @IBOutlet weak var tableView: UITableView!
    let textCellIdentifier = "TextCell"
    var pizzaList:[Pizza] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // create a reuseable cell row for each element in the pizza list array and
    // fill that row with all the member variables in the pizza object
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.numberOfLines = 0
        var order = pizzaList[row].pizzaSize
        order = order + "\n\t" + pizzaList[row].crust
        order = order + "\n\t" + pizzaList[row].cheese
        order = order + "\n\t" + pizzaList[row].meat
        order = order + "\n\t" + pizzaList[row].veggies
        cell.textLabel?.text = order
        return cell
    }
    
    // number of rows displayed is the number of elements in pizza list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    // append the new pizza to the pizza list and reload the tableview to account for new element
    func addPizza(newPizza: Pizza) {
        pizzaList.append(newPizza)
        tableView.reloadData()
    }
    
    // when the plus button is clicked, segue to the pizza view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PizzaSegue",
           let nextVC = segue.destination as? PizzaViewController {
            nextVC.delegate = self
        }
    }
}

