//
//  ViewController.swift
//  KanamangalaPreeth-HW5
//
// Project: KanamangalaPreeth-HW6
// EID: PK9297
// Course: CS371L
//

import UIKit
import FirebaseAuth
import CoreData

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
        
        // retrieve the objects from core data, create a "temp" pizza with the object data, and
        // append that new pizza to the pizzaList. after all this is done, we can reload the tableview data
        let oldPizzaList = retrievePizzas()
        
        for obj in oldPizzaList {
            let pizza = Pizza(size: obj.value(forKey: "pizzaSize") as! String,
                              crust: obj.value(forKey: "crust") as! String,
                              cheese: obj.value(forKey: "cheese") as! String,
                              meat: obj.value(forKey: "meat") as! String,
                              veggies: obj.value(forKey: "veggies") as! String)
            pizzaList.append(pizza)
        }
        
        tableView.reloadData()
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
    
    // snippet used from online
    // whenever we swipe the cell, delete it from the tableview and pizzalist
    // then, find the pizza at that specific row index, and delete it from core data
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pizzaList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            do {
                context.delete(retrievePizzas()[indexPath.row])
                try context.save()
            } catch {
                // If an error occurs
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    // number of rows displayed is the number of elements in pizza list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    // append the new pizza to the pizza list, then create a new pizza object and set its values for core data storage
    // reload the tableview to account for new element
    func addPizza(newPizza: Pizza) {
        pizzaList.append(newPizza)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let pizza = NSEntityDescription.insertNewObject(
            forEntityName: "Pizza", into: context)
        
        // set the attribute values
        pizza.setValue(newPizza.pizzaSize, forKey: "pizzaSize")
        pizza.setValue(newPizza.crust, forKey: "crust")
        pizza.setValue(newPizza.cheese, forKey: "cheese")
        pizza.setValue(newPizza.meat, forKey: "meat")
        pizza.setValue(newPizza.veggies, forKey: "veggies")
        
        // commit the changes
        do {
            try context.save()
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        tableView.reloadData()
    }
    
    // when the plus button is clicked, segue to the pizza view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PizzaSegue",
           let nextVC = segue.destination as? PizzaViewController {
            nextVC.delegate = self
        }
    }
    
    // when the logout button is pressed, sign out the current user
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Sign out error")
        }
    }
    
    // snippet used from class
    // request core data for a list of all the objects under the Pizza entity and return that
    func retrievePizzas() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Pizza")
        var fetchedResults:[NSManagedObject]? = nil
        
        do {
            try fetchedResults = context.fetch(request) as? [NSManagedObject]
        } catch {
            // if an error occurs
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        return(fetchedResults)!
    }
}

