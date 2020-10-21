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
        
        videoView = CLDVideoView(frame: CGRect(x: 0, y: 0, width: 200, height: 200), player: player)
        videoView.backgroundColor = .purple
        
        view.addSubview(videoView)
    }
}

// MARK: - extension UIView
extension UIView {
    
    func cld_addConstraintsToFill(_ parentView: UIView) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: parentView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: parentView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: parentView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: parentView, attribute: .bottom, multiplier: 1, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
