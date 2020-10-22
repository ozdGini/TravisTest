//
//  ViewController.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 21/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoView: CLDVideoView!
    var player: AVPlayer!
    var dogVideoPlaying: Bool = true
    
    
    var dogVideo: AVPlayerItem {
        let bundle = Bundle(for: Self.self)
        let url    = bundle.url(forResource: "dog", withExtension: "mov")!
        return AVPlayerItem(url:url)
    }
    
    var screenShotVideo: AVPlayerItem {
        let bundle = Bundle(for: Self.self)
        let url    = bundle.url(forResource: "ScreenRecording", withExtension: "mov")!
        return AVPlayerItem(url:url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        player = AVPlayer(playerItem: dogVideo)
        player.isMuted = true
        
        videoView = CLDVideoView(frame: CGRect(x: 0, y: 150, width: view.frame.width, height: 400), player: player)
        view.addSubview(videoView)
    }
    
    @IBAction func replaceVideoPressed(_ sender: UIButton) {
        
        dogVideoPlaying ? player.replaceCurrentItem(with: screenShotVideo) : player.replaceCurrentItem(with: dogVideo)
        
        dogVideoPlaying.toggle()
    }
}
