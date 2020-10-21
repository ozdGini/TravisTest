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

protocol CLDVideoControlsViewDelegate: class {
    func playPressedOnVideoControls (_ videoControls: CLDVideoControlsView)
    func pausePressedOnVideoControls(_ videoControls: CLDVideoControlsView)
}

class CLDVideoControlsView: UIControl {
    
    private(set) var playPauseButton: UIButton!
    private(set) var disappearTimer : CLDDisplayLinkObserver!
    weak         var delegate       : CLDVideoControlsViewDelegate?
    
    init(frame: CGRect, delegate: CLDVideoControlsViewDelegate?) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(backgroundPressed), for: .touchUpInside)
    }
    
    @objc private func backgroundPressed() {
           toggleControlsVisibility()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    private func toggleControlsVisibility() {
        
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
    
    private func startTimer() {
        
    }
    
    @objc private func timerTicks() {
        
    }
    
    @objc private func playPressed() {
        delegate?.playPressedOnVideoControls(self)
    }
    
    @objc private func pausePressed() {
        delegate?.pausePressedOnVideoControls(self)
    }
    
    /*
    func prepareControllersView() {
        
        // intial controllers view
        addTarget(self, action: #selector(toggleVideoBackgroundPressed), for: .touchUpInside)
        videoContainerView.addSubview(videoControlsView)
        cld_addConstraintsToFill(videoContainerView)
        videoContainerView.bringSubviewToFront(videoControlsView)

        // initial play button
        playButton = UIButton(type: .custom)
        playButton.setTitle("⏸", for: .normal)
        playButton.addTarget(self, action: #selector(togglePlayPressed), for: .touchUpInside)
        playButton.titleLabel?.font = playButton.titleLabel?.font.withSize(40)
        addSubview(playButton)
        playButton.cld_addConstraintsToCenter(videoControlsView)
    }*/

}
