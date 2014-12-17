//
//  ViewController.swift
//  WhatColourIsIt
//
//  Created by Iain on 17/12/2014.
//  Copyright (c) 2014 Iain Mullan. All rights reserved.
//

import UIKit


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var displayFormatter: NSDateFormatter;
    var colourFormatter: NSDateFormatter;
    var timer: NSTimer;
    
    required init(coder aDecoder: NSCoder) {
        
        self.displayFormatter = NSDateFormatter()
        self.displayFormatter.dateFormat = "HH:mm:ss"
        
        self.colourFormatter = NSDateFormatter()
        self.colourFormatter.dateFormat = "HHmmss"
        
        self.timer = NSTimer()
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startTimer() {
        
        updateTime()
        
        let aSelector : Selector = "updateTime"
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        
    }
    
    func stopTimer()
    {
        self.timer.invalidate()
    }
    
    func updateTime() {
        
        var now = NSDate()
        
        //code to set date style.....
        var displayTime: NSString = self.displayFormatter.stringFromDate(now)
        self.timeLabel.text = displayTime
        
        var colorTime: NSString = self.colourFormatter.stringFromDate(now)
        
        let scanner = NSScanner(string: "0x"+colorTime)
        
        var result : UInt32 = 0
        
        scanner.scanHexInt(&result)
        
        var resultInt : Int = Int(result)
        
        self.view.backgroundColor = UIColor(red:(resultInt >> 16) & 0xff, green:(resultInt >> 8) & 0xff, blue:resultInt & 0xff)
    }
    
    override func viewDidAppear(animated: Bool) {
        startTimer()
    }
    
    override func viewDidDisappear(animated: Bool) {
        stopTimer()
    }
    
}
