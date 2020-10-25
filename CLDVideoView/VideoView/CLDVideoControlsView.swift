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
    
    private var playPauseButton : UIButton!
    private var visibilityTimer : CLDDisplayLinkObserver!
    private var isPlaying       : Bool
    private var isShown         : Bool
    weak    var delegate        : CLDVideoControlsViewDelegate?
    
    private let transparentBackgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    // MARK: - init
    init(frame: CGRect, delegate: CLDVideoControlsViewDelegate?) {
        
        self.isPlaying = true
        self.isShown   = true
        self.delegate  = delegate
        super.init(frame: frame)
        
        visibilityTimer = CLDDisplayLinkObserver(delegate: self)
        
        addTarget(self, action: #selector(backgroundPressed), for: .touchUpInside)
        
        createUI()
        
        startTimer()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - handle events
extension CLDVideoControlsView {
    
    func videoEnded() {
        isShown = false
        toggleControlsVisibility()
        
        changeToPauseState()
    }
    
    @objc private func backgroundPressed() {
        toggleControlsVisibility()
    }
    
    private func toggleControlsVisibility() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            // we dont set the background alphe to 0 in order to keep getting touch events
            self.backgroundColor       = self.isShown ? UIColor.clear : self.transparentBackgroundColor
            self.playPauseButton.alpha = self.isShown ? 0.0 : 1.0
            
        }) { _ in
            self.isShown.toggle()
            
            if self.isShown,
               self.isPlaying {
                self.startTimer()
            } else {
                self.stopTimer()
            }
        }
    }
    
    @objc private func playPausePressed() {
        
        isPlaying ? changeToPauseState() : changeToPlayingState()
    }
    
    private func changeToPauseState() {
        
        delegate?.pausePressedOnVideoControls(self)
        playPauseButton.setTitle("▶", for: .normal)
        stopTimer()
        isPlaying = false
    }
    
    private func changeToPlayingState() {
        
        delegate?.playPressedOnVideoControls(self)
        playPauseButton.setTitle("||", for: .normal)
        startTimer()
        isPlaying = true
    }
}

// MARK: - display link timer
extension CLDVideoControlsView: CLDDisplayLinkObserverDelegate {
    
    private func startTimer() {
        visibilityTimer.delayValue = 2
        visibilityTimer.startTicker()
    }
    
    private func stopTimer() {
        visibilityTimer.stopTicker()
    }
    
    func displayLinkObserverDidTick(_ linkObserver: CLDDisplayLinkObserver) {
        toggleControlsVisibility()
        visibilityTimer.stopTicker()
    }
}

// MARK: - create UI
extension CLDVideoControlsView {
    
    private func createUI() {
        
        backgroundColor = transparentBackgroundColor
        
        playPauseButton = UIButton(type: .custom)
        playPauseButton.setTitle("||", for: .normal)
        playPauseButton.addTarget(self, action: #selector(playPausePressed), for: .touchUpInside)
        playPauseButton.titleLabel?.font = playPauseButton.titleLabel?.font.withSize(40)
        addSubview(playPauseButton)
        playPauseButton.cld_addConstraintsToCenter(self)
    }
}
