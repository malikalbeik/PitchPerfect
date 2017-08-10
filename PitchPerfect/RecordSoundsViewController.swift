//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Abdulmalek Albeik on 7/23/17.
//  Copyright © 2017 abdulmelik. All rights reserved.
//

import UIKit
import AVFoundation
var audioRecorder: AVAudioRecorder!

class RecordSoundsViewController: UIViewController{



    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!

    func setUIState(isRecording:Bool, recordingText:String){
        recordingLabel.text = recordingText
        if isRecording == true {
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        }else {
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewWillApear called")
    }

        
}

extension UIViewController : AVAudioRecorderDelegate{
    
    @IBAction func recordAudio(_ sender: Any) {
        
        setUIState(isRecording: true, recordingText: "Recording in progress")
        
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    @IBAction func stopRecording(_ sender: Any) {
        setUIState(isRecording: false, recordingText: "Tap to Record")
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
}

