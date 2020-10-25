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
        
        controlsView.delegate?.pausePressedOnVideoControls(controlsView)
        controlsView.playPauseButton.setTitle("▶", for: .normal)
        controlsView.stopTimer()
        controlsView.setNewState(newState: controlsView.shownAndPausedState)
    }
    
    func backgroundPressed() {
        
        hideControls()
    }
    
    func timerFinished() {
        
        hideControls()
    }
    
    func hideControls() {
        
        self.controlsView.stopTimer()
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.controlsView.hideControls()
            
        }) { _ in
            
            self.controlsView.setNewState(newState: self.controlsView.hiddenAndPlayingState)
        }
    }
    
    func videoEnded() {
        print("22222")
        controlsView.playPauseButton.setTitle("▶", for: .normal)
        controlsView.stopTimer()
        
        controlsView.setNewState(newState: self.controlsView.shownAndPausedState)
    }
}
