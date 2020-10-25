//
//  CLDVideoShownAndPausedState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import UIKit

class CLDVideoShownAndPausedState: NSObject, CLDVideoControlsState {
    
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        
        controlsView.delegate?.playPressedOnVideoControls(controlsView)
        controlsView.playPauseButton.setTitle("||", for: .normal)
        controlsView.startTimer()
        controlsView.setNewState(newState: controlsView.shownAndPlayingState)
    }
    
    func backgroundPressed() {
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.controlsView.hideControls()
            
        }) { _ in
            
            self.controlsView.setNewState(newState: self.controlsView.hiddenAndPausedState)
        }
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        print("shouldn't be called in this state")
    }
}
