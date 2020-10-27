//
//  CLDVideoHiddenAndPlayingState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import Foundation

class CLDVideoHiddenAndPlayingState: NSObject, CLDVideoControlsState {
    
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        print("shouldn't be called in this state")
    }
    
    func backgroundPressed() {
        
        print("CLDVideoHiddenAndPlayingState - backgroundPressed")
        
        controlsView.setNewState(newState: controlsView.shownAndPlayingState)
        controlsView.startTimer()
        
        controlsView.showControls()
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        print("CLDVideoHiddenAndPlayingState - videoEnded")
        controlsView.pauseVideo()
        
        controlsView.setNewState(newState: controlsView.shownAndPausedState)
        
        controlsView.showControls()
    }
}
