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
  
//    override func viewDidLoad() {
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isSwiping    = false
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
            UIGraphicsGetCurrentContext()?.setLineWidth(9.0)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: red)
            UIGraphicsGetCurrentContext()?.strokePath()
            
            self.drawView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            lastPoint = currentPoint
        }
    }
    
    
    
    
}
