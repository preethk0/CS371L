//
//  ViewController.swift
//  KanamangalaPreeth-HW7
//
// Project: KanamangalaPreeth-HW7
// EID: PK9297
// Course: CS371L
//

import UIKit

// class storing Timer structures for each cell
class Timer {
    var event: String
    var location: String
    var time: Int
    
    init(event:String, location:String, time:Int) {
        self.event = event
        self.location = location
        self.time = time
    }
}

// protocol to create a new timer
protocol CreateTimer {
    func addTimer(newTimer:Timer)
}

// protocol to update the timer when a user exits the VC
protocol TimerUpdate {
    func updateTimer(timerIndex: Int, newTime: Int)
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateTimer, TimerUpdate {

    @IBOutlet weak var tableView: UITableView!
    var timerList: [Timer] = []
    let textCellIdentifier = "TimerTable-ViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    // number of rows is number of elements in the timer list
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timerList.count
    }
    
    // create a cell for each Timer in the timer list and display all the attributes of that Timer in the cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath)
        let row = indexPath.row
        cell.textLabel?.numberOfLines = 0
        let timerDetails = "Event: " + timerList[row].event + "\nLocation: " + timerList[row].location
        cell.textLabel?.text = timerDetails
        cell.detailTextLabel?.text = "Remaining Time(s): " + String(timerList[row].time)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if timersegue is triggered, set the next VC delegate
        if segue.identifier == "TimerSegue",
           let nextVC = segue.destination as? AddTimerViewController {
            nextVC.delegate = self
        }
        
        // if the countdownsegue is triggered, pass along the index of the cell and the corresponding timer, and set next VC delegate
        if segue.identifier == "CountdownSegue",
           let nextVC = segue.destination as? CountdownViewController,
           let timerIndex = tableView.indexPathForSelectedRow?.row {
            nextVC.currentTimer = timerList[timerIndex]
            nextVC.timerIndex = timerIndex
            nextVC.delegate = self
        }
    }
    
    // add the new timer object to the timer list and reload
    func addTimer(newTimer: Timer) {
        timerList.append(newTimer)
        tableView.reloadData()
    }

    // update the input timer's time remaining with the input time
    func updateTimer(timerIndex: Int, newTime: Int) {
        timerList[timerIndex].time = newTime
        tableView.reloadData()
    }
}

