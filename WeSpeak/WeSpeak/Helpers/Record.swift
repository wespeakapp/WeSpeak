//
//  Record.swift
//  WeSpeak
//
//  Created by Girge on 11/30/16.
//  Copyright © 2016 WeSpeak. All rights reserved.
//

import Foundation
import AVFoundation

class Record {
    static var shared = Record()
    var documentsDirectory: URL
//    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var player: AVAudioPlayer!
    
    init() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        documentsDirectory = paths[0]
    }
    
    func start(nameFile: String) {
        let audioFilename = documentsDirectory.appendingPathComponent("\(nameFile).m4a")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        print("file: \(audioFilename.absoluteString)")
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
//            finishRecording(success: false)
            print("record start fail")
        }
    }
    
    func stop() {
        if audioRecorder != nil {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
    
    func play(nameFile: String) {
        let audioFilename = documentsDirectory.appendingPathComponent("\(nameFile).m4a")
        do {
            player = try AVAudioPlayer(contentsOf: audioFilename)
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func pause() {
        if player != nil {
            player.stop()
            player = nil
        }
    }
}
