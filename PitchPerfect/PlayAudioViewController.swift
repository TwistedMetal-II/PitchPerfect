//
//  PlayAudioViewController.swift
//  PitchPerfectProject
//
//  Created by Dharminder Rattu on 17.01.17.
//  Copyright © 2017 Dharminder Rattu. All rights reserved.
//

import UIKit
import AVFoundation

class PlayAudioViewController: UIViewController {

    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!

    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var stopPlaybackButton: UIButton!
    
    enum ButtonType: Int {
        case slow = 0, fast, lowPitch, highPitch
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()

    }

    @IBAction func playAudioForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .lowPitch:
            playSound(pitch: 1000)
        case .highPitch:
            playSound(pitch: -1000)
        }
        print(ButtonType.RawValue())
        configureUI(.playing)
    }

    @IBAction func stopPlaybackButton(_ sender: Any) {
        stopAudio()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
