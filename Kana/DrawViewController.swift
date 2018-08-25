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
    
    var stroke:CGFloat = 10.0
  
//    override func viewDidLoad() {
//
//    }
    func clear(){
        self.drawView.image = nil
        
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
