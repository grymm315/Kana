//
//  myVars.swift
//  Kana
//
//  Created by Chris Phillips on 11/6/15.
//  Copyright © 2015 Mad Men of Super Science, LLC. All rights reserved.
//

import Foundation
import UIKit


class myVars {
    
    var kanaType: String = "h_"
    var thisFrame: CGRect
    init(){
        kanaType = "h_"
        thisFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    
    func getKanaType()->String{
        
        return kanaType
        
    }
    func setKanaType(hiragana kana: String){
        kanaType = kana
    }
    
    
    func setBounds(frame frm:CGRect){
       thisFrame = frm
        
    }
    
    func getBounds()->CGRect{
        print("Umm \(thisFrame)")
        return thisFrame
        
    }
 
}








