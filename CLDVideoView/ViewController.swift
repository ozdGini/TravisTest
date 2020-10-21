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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle(for: Self.self)
        let url    = bundle.url(forResource: "ScreenRecording", withExtension: "mov")!
        let video  = AVPlayerItem(url:url)
        player = AVPlayer(playerItem: video)
        player.isMuted = true
        
        videoView = CLDVideoView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), player: player)
        view.addSubview(videoView)
    }
}
