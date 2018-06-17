//
//  kanaBttn.swift
//  Kana
//
//  Created by Chris Phillips on 10/29/15.
//  Copyright © 2015 Mad Men of Super Science, LLC. All rights reserved.
//

import Foundation
import AudioToolbox
import UIKit

class kanaBttn : UIButton {
    
    //HUGELY IMPORTANT!!! defines the image & sound
    var syllable: String = "a"
    var pronounced: String = "AWE"
    //Where the Button Starts
    var myStart: CGPoint =  CGPoint(x:0,y:0)
    //Size of the button
    let mySize: CGSize = CGSize(width: 50, height: 50 )
    
    
    
    //
    convenience init(str: String) {
        
        //Initialize the frame
        self.init(frame: CGRect.zero)
        self.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: mySize)
    
        //Pass the string into the syllable
        syllable = str

        commonInit()
        
    }

    //do I need this? maybe...
    override func awakeFromNib() {
        commonInit()
    }
  
    
    
     func commonInit() {
        
       
        
        
        //Where the button jumps to
        var goX: CGFloat
        var goY: CGFloat

        //Create spacing between buttons
        let divide: CGFloat = (access.thisFrame.width)/5
        let divideY: CGFloat = (access.thisFrame.height-50)/12
        
        let adjust: CGFloat = divide/2
        
        //Default define
        goX = divide-adjust
        goY = divideY
        
        
        //X position: won't move til update
        if syllable.contains("a"){
            goX = divide-adjust
        }
        if syllable.contains("i"){
            goX = divide*2-adjust
        }
        if syllable.contains("u"){
            goX = divide*3-adjust
        }
        if syllable.contains("e"){
            goX = divide*4-adjust
        }
        if syllable.contains("o"){
            goX = divide*5-adjust
        }
        
        //Y Position: won't move til update
        if syllable.contains("k"){
            goY = divideY*2
        }
        if syllable.contains("s"){
            goY = divideY*3
        }
        if syllable.contains("t"){
            goY = divideY*4
        }
        if syllable.contains("n"){
            if syllable == "n"{
            goY = divideY*11
            }else {
            goY = divideY*5
            }
        }
        if syllable.contains("h"){
            goY = divideY*6
        }
        if syllable.contains("m"){
            goY = divideY*7
        }
        if syllable.contains("y"){
            goY = divideY*8
        }
        if syllable.contains("r"){
            goY = divideY*9
        }
        if syllable.contains("w"){
            goY = divideY*10
        }
        
        
        
        myStart = CGPoint(x: goX, y: goY)
        
        
        //This timer will call an update to move everything into position
        _ = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(UIMenuController.update), userInfo: nil, repeats: false)
        
        
        
        //
        self.addTarget(self, action: Selector(("touchedSet:")), for: UIControlEvents.touchUpInside)
        
          }
    
    func pronouncedLike(){
        
        if (syllable == "a"){
        pronounced = "AWE"
        }
        if (syllable == "i"){
            pronounced = "AWE"
        }
        if (syllable == "u"){
            pronounced = "AWE"
        }
        if (syllable == "e"){
            pronounced = "AWE"
        }
        if (syllable == "o"){
            pronounced = "AWE"
        }
        
        if (syllable == "ka"){
            pronounced = "CAW"
        }
        if (syllable == "ki"){
            pronounced = "KEY"
        }
        if (syllable == "ku"){
            pronounced = "COO"
        }
        if (syllable == "ke"){
            pronounced = "KAY"
        }
        if (syllable == "ko"){
            pronounced = "CO"
        }
        
        if (syllable == "sa"){
            pronounced = "SAW"
        }
        if (syllable == "si"){
            pronounced = "SHE"
        }
        if (syllable == "su"){
            pronounced = "SUE"
        }
        if (syllable == "se"){
            pronounced = "SAY"
        }
        if (syllable == "so"){
            pronounced = "SO"
        }
        
        if (syllable == "ta"){
            pronounced = "TA"
        }
        if (syllable == "ti"){
            pronounced = "CHI"
        }
        if (syllable == "tu"){
            pronounced = "TSU"
        }
        if (syllable == "te"){
            pronounced = "TAY"
        }
        if (syllable == "to"){
            pronounced = "TOE"
        }
        
        if (syllable == "na"){
            pronounced = "NA"
        }
        if (syllable == "ni"){
            pronounced = "KNEE"
        }
        if (syllable == "nu"){
            pronounced = "NEW"
        }
        if (syllable == "ne"){
            pronounced = "NAY"
        }
        if (syllable == "no"){
            pronounced = "NO"
        }
        
        if (syllable == "ha"){
            pronounced = "HA"
        }
        if (syllable == "hi"){
            pronounced = "HE"
        }
        if (syllable == "hu"){
            pronounced = "WHO"
        }
        if (syllable == "he"){
            pronounced = "HEY"
        }
        if (syllable == "ho"){
            pronounced = "HOE"
        }
        
        if (syllable == "ma"){
            pronounced = "MA"
        }
        if (syllable == "mi"){
            pronounced = "ME"
        }
        if (syllable == "mu"){
            pronounced = "MOO"
        }
        if (syllable == "me"){
            pronounced = "MEH"
        }
        if (syllable == "mo"){
            pronounced = "MOE"
        }
        
        if (syllable == "ya"){
            pronounced = "YA"
        }
        if (syllable == "yu"){
            pronounced = "YOU"
        }
        if (syllable == "yo"){
            pronounced = "YO"
        }
        
        if (syllable == "ra"){
            pronounced = "RA"
        }
        if (syllable == "ri"){
            pronounced = "REE"
        }
        if (syllable == "ru"){
            pronounced = "ROO"
        }
        if (syllable == "re"){
            pronounced = "RAY"
        }
        if (syllable == "ro"){
            pronounced = "RO"
        }
        
        if (syllable == "wa"){
            pronounced = "WAH"
        }
        if (syllable == "wo"){
            pronounced = "WOE"
        }
        if (syllable == "n"){
            pronounced = "N"
        }
      
        
        
    }
    
    func update(){
        //Update the image, for changing from Hirigana to Katakana
        var imgLbl: String = access.kanaType//"k_"
        imgLbl.append(syllable)
        imgLbl.append(".png")
        print(imgLbl, "umm_\(syllable)")
        self.setImage(UIImage(named: imgLbl)?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: .normal)
        
       
        self.tintColor = UIColor.white
        
        //Move the button into position
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {self.center = self.myStart}, completion: nil)
        
    }
    
    func stopHighlight(){
      // self.highlighted = false
      //  self.tintColor = UIColor.whiteColor()
        UIView.animate(withDuration: 0.8, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { self.tintColor = UIColor.white }, completion: nil)
    }
    
    func wasHeard(){
        
        self.tintColor = UIColor.red
                stopHighlight()
        
    }
    //move the button offscreen
    func goByeBye(){
        
        let byeBye = CGPoint(x: -100, y: -100)
     
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {self.center = byeBye}, completion: nil)
        
        print("bye bye: "+syllable)
        
    }
    
    //if the button is touched, play a sound
    func touchedSet(sender: UIButton!) {
        
        self.tintColor = UIColor.red
        _ = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: Selector(("stopHighlight")), userInfo: nil, repeats: false)
       
        
        
        print(syllable)
        
        
        if let soundURL = Bundle.main.url(forResource: syllable, withExtension: "wav") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);

    }
    
    }


}
