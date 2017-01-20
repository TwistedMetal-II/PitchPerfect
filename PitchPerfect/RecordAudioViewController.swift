//
//  ViewController.swift
//  PitchPerfectProject
//
//  Created by Dharminder Rattu on 15.01.17.
//  Copyright © 2017 Dharminder Rattu. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {
    
    @IBOutlet weak var recordAndStopButton: UIButton!
    
    var flag: Bool = false
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func recordAndStopButton(_ sender: UIButton) {
        
        print("button pressed \(flag)")
        
        if(!flag){
            //Recording button
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            
            try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            audioRecorder.isMeteringEnabled = true
            audioRecorder.prepareToRecord()
            audioRecorder.record()

            sender.setImage(UIImage(named: "Stop.png"), for: UIControlState.normal)
            flag = true
        } else {
            //Stop button
            audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
            
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            sender.setImage(UIImage(named: "Record.png"), for: UIControlState.normal)
            flag = false
        }
    }
    
    override func prepare(for Segue: UIStoryboardSegue, sender: Any?){
        
        if(Segue.identifier == "stopRecording"){
            let playAudioViewController = Segue.destination as! PlayAudioViewController
            let recordedAudioURL = sender as! URL
            playAudioViewController.recordedAudioURL = recordedAudioURL
        }
    }
    
}

