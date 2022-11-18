//
//  ViewController.swift
//  KanamangalaPreeth-HW9
//
// Project: KanamangalaPreeth-HW9
// EID: PK9297
// Course: CS371L
//

import UIKit

class ViewController: UIViewController {
    
    var width: Double = 0
    var height: Double = 0
    var direction: String = "Down"
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up the block view based on safe area width and height and assignment constraints
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
        let viewHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        let blockView = UIView(frame: CGRect(x: viewWidth * 0.5 - viewWidth * (1/18), y: viewHeight * 0.5 - viewHeight * (1/38),
                                             width: viewWidth * (1/9), height: viewHeight * (1/19)))
        blockView.backgroundColor = UIColor.green
        
        width = viewWidth * (1/9)
        height = viewHeight * (1/19)
        
        // add the tap gesture recognizer to the block view
        let tap = UITapGestureRecognizer(target: self, action: #selector(recognizeTapGesture(recognizer:)))
        blockView.addGestureRecognizer(tap)
        
        self.view.addSubview(blockView)
        
        addSwipeRecognizer()
    }
    
    // when the view appears, start the move block sequence
    override func viewDidAppear(_ animated: Bool) {
        moveBlock()
    }
    
    func moveBlock() {
        // run all of the block movement code every 0.3 seconds with the timer
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { _ in
            let blockView = self.view.subviews[0]
            let x = blockView.frame.origin.x
            let y = blockView.frame.origin.y
            let safeView = self.view.safeAreaLayoutGuide.layoutFrame
            
            // check if the edges of the block have reached the safe area border
            if(round(x + self.width) < safeView.maxX && x - self.width > safeView.minX && y + self.height < safeView.maxY && y - self.height > safeView.minY) {
                // based on the global direction variable, change the x or y position of the block view
                switch self.direction {
                case "Down":
                    blockView.frame.origin.y += self.height
                case "Right":
                    blockView.frame.origin.x += self.width
                case "Left":
                    blockView.frame.origin.x -= self.width
                case "Up":
                    blockView.frame.origin.y -= self.height
                default:
                    break
                }
            } else {
                // if the safe area boarder is reached, change the block color and exit the timer
                blockView.backgroundColor = UIColor.red
                self.timer.invalidate()
            }
        })
    }
    
    // add the swipe recognizers for all the directions
    func addSwipeRecognizer() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(recognizeSwipeGesture(recognizer:)))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // recognize which direction has been reached for the swipe gesture, then set the respective global direction variable
    @IBAction func recognizeSwipeGesture(recognizer: UISwipeGestureRecognizer)
    {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case UISwipeGestureRecognizer.Direction.right:
                direction = "Right"
            case UISwipeGestureRecognizer.Direction.down:
                direction = "Down"
            case UISwipeGestureRecognizer.Direction.left:
                direction = "Left"
            case UISwipeGestureRecognizer.Direction.up:
                direction = "Up"
            default:
                break
            }
        }
    }
    
    // when the block view is tapped, reset the position, color, and direction
    @IBAction func recognizeTapGesture(recognizer: UITapGestureRecognizer) {
        let blockView = self.view.subviews[0]
        let viewWidth = self.view.safeAreaLayoutGuide.layoutFrame.width
        let viewHeight = self.view.safeAreaLayoutGuide.layoutFrame.height
        
        blockView.frame.origin.x = viewWidth * 0.5 - viewWidth * (1/18)
        blockView.frame.origin.y = viewHeight * 0.5 - viewHeight * (1/38)
        blockView.backgroundColor = UIColor.green
        direction = "Down"
        
        self.timer.invalidate()
        moveBlock()
    }
}
