//
//  AudioPlayer.swift
//  Restart
//
//  Created by Benjamin on 09/04/2022.
//

import Foundation
import AVFoundation

var audioPlayer:AVAudioPlayer?

func playSound(sound:String, type:String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:  path))
            audioPlayer?.play()
        }catch{
         print("Could not play audio file")
        }
    }
}
