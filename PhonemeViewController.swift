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

var lmPath: String!
var dicPath: String!
var words: Array<String> = []
var currentWord: String!

var kLevelUpdatesPerSecond = 18

class PhonemeViewController: UIViewController, OEEventsObserverDelegate {
    
    var openEarsEventsObserver = OEEventsObserver()
    var startupFailedDueToLackOfPermissions = Bool()
    
    var buttonFlashing = false
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var heardTextView: UITextView!
  
    
    
    override func viewDidLoad() {
        
        
        
        //initiate standard viewDidLoad startup
        super.viewDidLoad()
        
       loadOpenEars()
        
        
        //pass the view size into a global variable that can be used in other classes
       access.thisFrame = CGRect(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2, width: self.view.frame.size.width, height: self.view.frame.size.height)

        
        //Setup and play a sound
        if let soundURL = Bundle.main.url(forResource: "wawish", withExtension: "wav") {
            var mySound: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);}
        
        //adding the buttons to the view
        
        self.view.addSubview(addKana("a"))
        self.view.addSubview(addKana("i"))
        self.view.addSubview(addKana("u"))
        self.view.addSubview(addKana("e"))
        self.view.addSubview(addKana("o"))
        //k
        self.view.addSubview(addKana("ka"))
        self.view.addSubview(addKana("ki"))
        self.view.addSubview(addKana("ku"))
        self.view.addSubview(addKana("ke"))
        self.view.addSubview(addKana("ko"))
        //s
        self.view.addSubview(addKana("sa"))
        self.view.addSubview(addKana("si"))
        self.view.addSubview(addKana("su"))
        self.view.addSubview(addKana("se"))
        self.view.addSubview(addKana("so"))
        //t
        self.view.addSubview(addKana("ta"))
        self.view.addSubview(addKana("ti"))
        self.view.addSubview(addKana("tu"))
        self.view.addSubview(addKana("te"))
        self.view.addSubview(addKana("to"))
        //n
        self.view.addSubview(addKana("na"))
        self.view.addSubview(addKana("ni"))
        self.view.addSubview(addKana("nu"))
        self.view.addSubview(addKana("ne"))
        self.view.addSubview(addKana("no"))
        //h
        self.view.addSubview(addKana("ha"))
        self.view.addSubview(addKana("hi"))
        self.view.addSubview(addKana("hu"))
        self.view.addSubview(addKana("he"))
        self.view.addSubview(addKana("ho"))
        //m
        self.view.addSubview(addKana("ma"))
        self.view.addSubview(addKana("mi"))
        self.view.addSubview(addKana("mu"))
        self.view.addSubview(addKana("me"))
        self.view.addSubview(addKana("mo"))
        //y
        self.view.addSubview(addKana("ya"))
//        self.view.addSubview(addKana("yi"))
        self.view.addSubview(addKana("yu"))
//        self.view.addSubview(addKana("ye"))
        self.view.addSubview(addKana("yo"))
        //r
        self.view.addSubview(addKana("ra"))
        self.view.addSubview(addKana("ri"))
        self.view.addSubview(addKana("ru"))
        self.view.addSubview(addKana("re"))
        self.view.addSubview(addKana("ro"))
        //w
        self.view.addSubview(addKana("wa"))
        self.view.addSubview(addKana("wo"))
        
        self.view.addSubview(addKana("n"))
     
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
        
        self.openEarsEventsObserver = OEEventsObserver()
        self.openEarsEventsObserver.delegate = self
        
        let lmGenerator: OELanguageModelGenerator = OELanguageModelGenerator()
        
        addWords()
        let name = "Vowels"
        //var correctPath: NSString = NSString[]
    
        print(OEAcousticModel.path(toModel: "AcousticModelEnglish"))
        
        lmGenerator.generateLanguageModel(from: words, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.path(toModel: "AcousticModelEnglish"))
        
        lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModel(withRequestedName: name)
        dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionary(withRequestedName: name)
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
        words.append("AWE")
        words.append("E")
        words.append("OOH")
        words.append("EH")
        words.append("OH")
        
        words.append("CAW")
        words.append("KEY")
        words.append("COO")
        words.append("KAY")
        words.append("CO")
        
        words.append("SAW")
        words.append("SHE")
        words.append("SUE")
        words.append("SAY")
        words.append("SO")
        //ta
        words.append("TA")
        words.append("CHI")
        words.append("TSU")
        words.append("TAY")
        words.append("TOE")
        
        //na
        words.append("NAH")
        words.append("KNEE")
        words.append("NEW")
        words.append("NAY")
        words.append("NO")
        //ha
        words.append("HA")
        words.append("HE")
        words.append("WHO")
        words.append("HAY")
        words.append("HOE")
        //ma
        words.append("MA")
        words.append("ME")
        words.append("MOO")
        words.append("MEH")
        words.append("MO")
        //ya
        words.append("YAH")
        words.append("YOU")
        words.append("YO")

        //ra
        words.append("RA")
        words.append("REE")
        words.append("ROO")
        words.append("RAY")
        words.append("ROE")
        //wa
        words.append("WAH")
        words.append("WOE")
        //n
        words.append("N")
     
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
    func addKana(_: String)-> kanaBttn {
    
        var button: kanaBttn
        
        
        
        button = kanaBttn(str: "a")   //frame: CGRect(x: 10, y: 40, width: 50, height: 50))
        
        return button
        
        
    }
    
    //set animate events for when objects dissappear
    
        func viewWillDisappear(animated: Bool) {
        
            if let soundURL = Bundle.main.url(forResource: "wawish", withExtension: "wav") {
            var mySound: SystemSoundID = 0
                AudioServicesCreateSystemSoundID(soundURL as CFURL, &mySound)
            // Play
            AudioServicesPlaySystemSound(mySound);}
        
        
            events.trigger(eventName: "byebye")
        
       // kanaBttn().goByeBye()
        
      
        
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        //self.dataLabel!.text = dataObject
//    }
//    

    
    
    

    
