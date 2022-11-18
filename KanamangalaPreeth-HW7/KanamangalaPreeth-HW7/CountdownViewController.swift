//
//  CountdownViewController.swift
//  KanamangalaPreeth-HW7
//
// Project: KanamangalaPreeth-HW7
// EID: PK9297
// Course: CS371L
//

import UIKit
import Foundation

class CountdownViewController: UIViewController {
    
    var delegate: UIViewController!
    var currentTimer: Timer?
    var timerIndex: Int = 0
    var currentTime: Int = 0
    
    @IBOutlet weak var eventField: UILabel!
    @IBOutlet weak var locationField: UILabel!
    @IBOutlet weak var timeField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentTime = currentTimer!.time
        
        // set the UI labels to the the values from the Timer passed in
        eventField.text = currentTimer?.event
        locationField.text = currentTimer?.location
        timeField.text = String(currentTime)
        
        countdown()
    }
    
    // create a thread where the current time ticks down every second, and displays on the UI label, until it hits 0
    func countdown() {
        let queue = DispatchQueue(label: "TimerQueue", qos: .default)
        
        queue.async {
            while(self.currentTime > 0) {
                sleep(1)
                self.currentTime -= 1
                
                DispatchQueue.main.async {
                    self.timeField.text = String(self.currentTime)
                }
            }
        }
    }
    
    // when the view is about to disappear, update the current Timer object using the TimerUpdate protocol with the time when the user exited the view controller
    override func viewWillDisappear(_ animated: Bool) {
        let otherVC = delegate as! TimerUpdate
        otherVC.updateTimer(timerIndex: timerIndex, newTime: currentTime)
        self.dismiss(animated: false, completion: nil)
    }
}
