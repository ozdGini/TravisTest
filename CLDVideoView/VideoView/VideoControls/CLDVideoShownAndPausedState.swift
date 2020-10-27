//
//  CLDVideoShownAndPausedState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import Foundation

class CLDVideoShownAndPausedState: NSObject, CLDVideoControlsState {
    
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        
        print("CLDVideoShownAndPausedState - playPausePressed")
        controlsView.playVideo()
        
        controlsView.setNewState(newState: controlsView.shownAndPlayingState)
    }
    
    func backgroundPressed() {
        
        print("CLDVideoShownAndPausedState - backgroundPressed")
        
        controlsView.setNewState(newState: controlsView.hiddenAndPausedState)
        
        controlsView.hideControls()
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        print("shouldn't be called in this state")
    }
}
