//
//  CLDVideoShownAndPlayingState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import UIKit

class CLDVideoShownAndPlayingState: NSObject, CLDVideoControlsState {
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        print("CLDVideoShownAndPlayingState - playPausePressed")
        controlsView.delegate?.pausePressedOnVideoControls(controlsView)
        controlsView.playPauseButton.setTitle("▶", for: .normal)
        controlsView.stopTimer()
        controlsView.setNewState(newState: controlsView.shownAndPausedState)
    }
    
    func backgroundPressed() {
        print("CLDVideoShownAndPlayingState - backgroundPressed")
        hideControls()
    }
    
    func timerFinished() {
        print("CLDVideoShownAndPlayingState - timerFinished")
        hideControls()
    }
    
    func hideControls() {

        self.controlsView.stopTimer()
        self.controlsView.setNewState(newState: self.controlsView.hiddenAndPlayingState)
        
        UIView.animate(withDuration: 0.2, animations: {
            self.controlsView.hideControls()
        })
    }
    
    func videoEnded() {
        print("CLDVideoShownAndPlayingState - videoEnded")
        controlsView.playPauseButton.setTitle("▶", for: .normal)
        controlsView.stopTimer()
        
        controlsView.setNewState(newState: self.controlsView.shownAndPausedState)
    }
}
