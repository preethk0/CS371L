//
//  ViewController.swift
//  KanamangalaPreeth-HW8
//
// Project: KanamangalaPreeth-HW8
// EID: PK9297
// Course: CS371L
//

import UIKit
import UserNotifications

// counter for how many times the images have been pressed
var buttonCounter: Int = 0

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    var currentImage: String = "uttower.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // when the view loads, set the initial picture as the tower and request notification authorization
        button.setImage(UIImage(named: currentImage), for: .normal)
        requestNotifAuthorization()
    }
    
    // animate out the previous image and animate in the image that is passed in as input
    func showImage(image: String) {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseOut, animations: {self.button.alpha = 0.0},
            completion: {_ in
                self.button.setImage(UIImage(named: image), for: .normal)
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn, animations: {self.button.alpha = 1.0}, completion: nil)
            }
        )
    }
    
    // request the user to allow notifcations, taken from class demo
    func requestNotifAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge,.sound]) {
            success, error in
            if success  {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    // push a notification to the home screen regarding how many times the user clicked the images, taken from class demo
    func sendNotif() {
        // create content
        let content = UNMutableNotificationContent()
        content.title = "Click Count"
        content.subtitle = "Let's see how many times you've clicked!"
        content.body = "You have clicked " + String(buttonCounter) + " times"
        content.sound = UNNotificationSound.default
        
        // create trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 8.0, repeats: false)
        
        // combine it all into a request
        let request = UNNotificationRequest(identifier: "counterNotif", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // whenever the button is pressed, increment the counter and change the current image, then pass that into the show image func
    // if this button has been pressed a multiple of 4 times, send a push notif
    @IBAction func buttonPressed(_ sender: Any) {
        buttonCounter += 1
        
        if currentImage == "uttower.png" {
            currentImage = "ut.png"
        } else {
            currentImage = "uttower.png"
        }
        
        showImage(image: currentImage)
        
        if buttonCounter % 4 == 0 {
            sendNotif()
        }
    }
}

