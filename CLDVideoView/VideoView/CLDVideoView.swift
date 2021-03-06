//
//  CLDVideoControlsView.swift
//
//  Copyright (c) 2020 Cloudinary (http://cloudinary.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import AVKit

class CLDVideoView: UIView {

    private var videoControlsView: CLDVideoControlsView!
    private var videoPlayerView  : CLDVideoPlayerView!
    private var player           : AVPlayer
    
    init(frame: CGRect, player: AVPlayer) {
        
        self.player = player
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - CLDVideoControlsViewDelegate
extension CLDVideoView: CLDVideoControlsViewDelegate {
    
    func playPressedOnVideoControls(_ videoControls: CLDVideoControlsView) {
        player.play()
    }
    
    func pausePressedOnVideoControls(_ videoControls: CLDVideoControlsView) {
        player.pause()
    }
}

// MARK: - create UI
extension CLDVideoView {
    
    private func createUI() {
        
        videoControlsView = CLDVideoControlsView(frame: frame, delegate: self)
        videoPlayerView   = CLDVideoPlayerView  (frame: frame)
        
        addSubview(videoPlayerView)
        addSubview(videoControlsView)
        
        videoPlayerView  .cld_addConstraintsToFill(self)
        videoControlsView.cld_addConstraintsToFill(self)
        
        guard let playerLayer = videoPlayerView.playerLayer else { return }
        playerLayer.player = player
        
        NotificationCenter.default.addObserver(self, selector: #selector(videoEnded), name: .AVPlayerItemDidPlayToEndTime, object: nil)
        player.play()
    }
    
    @objc private func videoEnded() {
        player.seek(to: CMTime.zero)
        videoControlsView.videoEnded()
    }
}
