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
    
    enum controlState {
        
        case shownAndPlaying
        case shownAndPaused
        case hiddenAndPlaying
        case hiddenAndPaused
    }
    
            var playPauseButton  : UIButton!
    private var visibilityTimer  : CLDDisplayLinkObserver!
    
    weak    var delegate         : CLDVideoControlsViewDelegate?
    
    private(set) var currentState         : CLDVideoControlsState!
    private(set) var shownAndPlayingState : CLDVideoControlsState!
    private(set) var shownAndPausedState  : CLDVideoControlsState!
    private(set) var hiddenAndPlayingState: CLDVideoControlsState!
    private(set) var hiddenAndPausedState : CLDVideoControlsState!
    
    let transparentBackgroundColor = UIColor.black.withAlphaComponent(0.5)
    
    // MARK: - init
    init(frame: CGRect, delegate: CLDVideoControlsViewDelegate?) {
    
        self.delegate  = delegate
        
        super.init(frame: frame)
        
        // handle state
        self.shownAndPlayingState  = CLDVideoShownAndPlayingState (controlsView: self)
        self.shownAndPausedState   = CLDVideoShownAndPausedState  (controlsView: self)
        self.hiddenAndPlayingState = CLDVideoHiddenAndPlayingState(controlsView: self)
        self.hiddenAndPausedState  = CLDVideoHiddenAndPausedState (controlsView: self)
        self.currentState          = self.shownAndPlayingState
        
        visibilityTimer = CLDDisplayLinkObserver(delegate: self)
        startTimer()
        
        addTarget(self, action: #selector(backgroundPressed), for: .touchUpInside)
        
        createUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// MARK: - handle events
extension CLDVideoControlsView {
    
    func videoEnded() {
        currentState.videoEnded()
    }
    
    @objc private func backgroundPressed() {
        currentState.backgroundPressed()
    }
    
    @objc private func playPausePressed() {
        currentState.playPausePressed()
    }
}

// MARK: - handle state
extension CLDVideoControlsView {
    
    func setNewState(newState: CLDVideoControlsState) {
        currentState = newState
    }
}

// MARK: - display link timer
extension CLDVideoControlsView: CLDDisplayLinkObserverDelegate {
    
    func startTimer() {
        visibilityTimer.stopTicker()
        visibilityTimer.delayValue = 2
        visibilityTimer.startTicker()
    }
    
    func stopTimer() {
        visibilityTimer.stopTicker()
    }
    
    func displayLinkObserverDidTick(_ linkObserver: CLDDisplayLinkObserver) {
        currentState.timerFinished()
    }
}

// MARK: - UI
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
    
    func showControls() {
        
        self.backgroundColor       = self.transparentBackgroundColor
        self.playPauseButton.alpha = 1.0
    }
    
    func hideControls() {
        
        // we dont set the background alphe to 0 in order to keep getting touch events
        self.backgroundColor       = UIColor.clear
        self.playPauseButton.alpha = 0.0
    }
}
