//
//  PhonemeViewController.swift
//  Kana
//
//  Created by Chris Phillips on 11/6/15.
//  Copyright © 2015 Mad Men of Super Science, LLC. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class PhonemeViewController: UIViewController, OEEventsObserverDelegate {
    
    var lmPath: String!
    var dicPath: String!
    
    let words: Array<String> =         ["AWE","E","OOH","EH","OH",
                                        "CAW","KEY","COO","KAY","CO",
                                        "SAW","SHE","SUE","SAY","SO",
                                        "TA","CHI","TSU","TAY","TOE",
                                        "NAH","KNEE","NEW","NAY","NO",
                                        "HA","HE","WHO","HAY","HOE",
                                        "MA","ME","MOO","MEH","MO",
                                        "YAH","YOU","YO",
                                        "RA","REE","ROO","RAY","ROE",
                                        "WAH","WOE",
                                        "N"]
    
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
    
    
    var currentWord: String!
    
    var kLevelUpdatesPerSecond = 18
    
    var openEarsEventsObserver = OEEventsObserver()
    var startupFailedDueToLackOfPermissions = Bool()
    
    var buttonFlashing = false
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var heardTextView: UITextView!
  
    
    
    override func viewDidLoad() {
        if (UserDefaults.standard.string(forKey: "kanaType") == nil){
            UserDefaults.standard.set("h_", forKey: "kanaType")
        }
        
        //initiate standard viewDidLoad startup
        super.viewDidLoad()
        
       loadOpenEars()
        
        //Setup and play a sound
        if let soundURL = Bundle.main.url(forResource: "wawish", withExtension: "wav") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);}
        
        for letter in alphabet{
           self.view.addSubview(addKana(letter: letter))
        }

    }
    
    
    @IBAction func record(sender: AnyObject) {
        
        if !buttonFlashing {
            startFlashingbutton()
            startListening()
        } else {
            stopFlashingbutton()
            stopListening()
        }
        
    }
    
    
    func startFlashingbutton() {
        
        buttonFlashing = true
        recordButton.tintColor = UIColor.red
        recordButton.alpha = 0.5
    }
    
    func stopFlashingbutton() {
        buttonFlashing = false
        recordButton.tintColor = nil
    }
    //OpenEars methods begin
    
    func loadOpenEars() {
        
//        self.openEarsEventsObserver = OEEventsObserver()
//        self.openEarsEventsObserver.delegate = self
//
//        let lmGenerator: OELanguageModelGenerator = OELanguageModelGenerator()
//
//        addWords()
//        let name = "Vowels"
//        //var correctPath: NSString = NSString[]
//
//        print(OEAcousticModel.path(toModel: "AcousticModelEnglish"))
//
//        lmGenerator.generateLanguageModel(from: words, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"))
//
//        lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: name)
//        dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: name)
    }
    
    
    func pocketsphinxDidStartListening() {
        print("Pocketsphinx is now listening.")
        
    }
    
    func pocketsphinxDidDetectSpeech() {
        print("Pocketsphinx has detected speech.")
       
    }
    
    func pocketsphinxDidDetectFinishedSpeech() {
        print("Pocketsphinx has detected a period of silence, concluding an utterance.")
        
    }
    
    func pocketsphinxDidStopListening() {
        print("Pocketsphinx has stopped listening.")
        
    }
    
    func pocketsphinxDidSuspendRecognition() {
        print("Pocketsphinx has suspended recognition.")
        
    }
    
    func pocketsphinxDidResumeRecognition() {
        print("Pocketsphinx has resumed recognition.")
        
    }
    
    func pocketsphinxDidChangeLanguageModelToFile(newLanguageModelPathAsString: String, newDictionaryPathAsString: String) {
        print("Pocketsphinx is now using the following language model: \(newLanguageModelPathAsString) and the following dictionary: \(newDictionaryPathAsString)")
    }
    
    func pocketSphinxContinuousSetupDidFailWithReason(reasonForFailure: String) {
        print("Listening setup wasn't successful and returned the failure reason: \(reasonForFailure)")
       
    }
    
    func pocketSphinxContinuousTeardownDidFailWithReason(reasonForFailure: String) {
        print("Listening teardown wasn't successful and returned the failure reason: \(reasonForFailure)")
        
    }
    
    func testRecognitionCompleted() {
        print("A test file that was submitted for recognition is now complete.")
      
    }
    
    func startListening() {
        do {try OEPocketsphinxController.sharedInstance().setActive(true)} catch {
            
        }//setActive(true, error: nil)
       
        
        OEPocketsphinxController.sharedInstance().startListeningWithLanguageModel(atPath: lmPath, dictionaryAtPath: dicPath, acousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"), languageModelIsJSGF: false)
    }
    
    func stopListening() {
        OEPocketsphinxController.sharedInstance().stopListening()
    }
    
    func addWords() {
        //add any thing here that you want to be recognized. Must be in capital letters
        
     
    }
    
    func getNewWord() {
        let randomWord = Int(arc4random_uniform(UInt32(words.count)))
        currentWord = words[randomWord]
    }
    
    func pocketsphinxFailedNoMicPermissions() {
        
        NSLog("Local callback: The user has never set mic permissions or denied permission to this app's mic, so listening will not start.")
        self.startupFailedDueToLackOfPermissions = true
        if OEPocketsphinxController.sharedInstance().isListening {
            let error = OEPocketsphinxController.sharedInstance().stopListening() // Stop listening if we are listening.
            if(error != nil) {
                print("Error while stopping listening in micPermissionCheckCompleted: \(String(describing: error))");
            }
        }
    }
    
    func pocketsphinxDidReceiveHypothesis(_ hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        print("Heard: \(hypothesis)")
    }
}

    //function for adding button
    func addKana(letter: String)-> kanaBttn {
    
        var button: kanaBttn

        button = kanaBttn(str: letter)   //frame: CGRect(x: 10, y: 40, width: 50, height: 50))
        
        return button
    }
    
    //set animate events for when objects dissappear
    
        func viewWillDisappear(animated: Bool) {
        
            if let soundURL = Bundle.main.url(forResource: "wawish", withExtension: "wav") {
            var mySound: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);}
        
    }
    


    
    
    

    
