//
//  ViewController.swift
//  KanamangalaPreeth-HW4
//
// Project: KanamangalaPreeth-HW4
// EID: PK9297
// Course: CS371L
//

import UIKit

// data source with operations in string
public let operations = [ "Add", "Subtract", "Multiply", "Divide"]

let textCellIdentifier = "TextCell"
let segueIdentifier = "OperationSegue"

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    // set the delegate and data source to self
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // return number of rows as the number of operations in the data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    // make a reusable cell for the row seen on the UI
    // fill the text of that cell with the respective (row based index) operation in the data source
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.text = operations[row]
        
        return cell
    }
    
    // when a cell row is selected, deselect it
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        print(operations[row])
    }

    // clicking the cell segues to the other view controller, where we pass the operation of
    // the row clicked into a variable at the destination VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier,
           let destination = segue.destination as? CalculatorViewController,
           let operationIndex = tableView.indexPathForSelectedRow?.row {
            destination.operation = operations[operationIndex]
        }
        
    }
}

