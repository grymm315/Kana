//
//  DrawViewController.swift
//  Kana
//
//  Created by Chris Phillips on 6/23/18.
//  Copyright © 2018 Mad Men of Super Science, LLC. All rights reserved.
//

import Foundation
import CoreGraphics


class DrawViewController: UIViewController {
    
    @IBOutlet weak var drawView: UIImageView!
    var lastPoint:CGPoint!
    var isSwiping:Bool!
    
    let red:CGFloat = 255
    let green:CGFloat = 255
    let blue:CGFloat = 255
    let pop = PopUp()
    var stroke:CGFloat = 10.0
    
    let alphabet = ["a", "i", "u", "e", "o",
                    "ka", "ki", "ku", "ke", "ko",
                    "sa", "si", "su", "se", "so",
                    "ta", "ti", "tu", "te", "to",
                    "na", "ni", "nu", "ne", "no",
                    "ha", "hi", "hu", "he", "ho",
                    "ma", "mi", "mu", "me", "mo",
                    "ya", "yu", "yo",
                    "ra", "ri", "ru", "re", "ro",
                    "wa", "wo",
                    "n"]
  
    override func viewDidLoad() {
        pop.mData = alphabet
    }
    func clear(){
        self.drawView.image = nil
        
    }
    
    @IBAction func PopButton(_ sender: Any) {
        let but = sender as! UIButton
        pop.startFrame = but.frame
        self.view.addSubview(pop.view)
    }
    
    @IBAction func clearView(_ sender: Any) {
        self.drawView.image = nil
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSwiping    = false
        stroke = 10.0
        if let touch = touches.first{
            lastPoint = touch.location(in: drawView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
  
        isSwiping = true;
        if let touch = touches.first{
            let currentPoint = touch.location(in: drawView)
            UIGraphicsBeginImageContext(self.drawView.frame.size)
            self.drawView.image?.draw(in: drawView.frame)
            UIGraphicsGetCurrentContext()?.move(to: lastPoint)
            UIGraphicsGetCurrentContext()?.addLine(to: currentPoint)
            UIGraphicsGetCurrentContext()?.setLineCap(.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(stroke)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: red)
            UIGraphicsGetCurrentContext()?.strokePath()
            
            self.drawView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
            if (stroke > 1){
                stroke -= 0.15
            }
        }
    }
    
    
    
    
}
