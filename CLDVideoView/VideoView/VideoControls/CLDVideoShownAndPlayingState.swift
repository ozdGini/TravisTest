//
//  CLDVideoShownAndPlayingState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import Foundation

class CLDVideoShownAndPlayingState: NSObject, CLDVideoControlsState {
    
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        
        print("CLDVideoShownAndPlayingState - playPausePressed")
        controlsView.pauseVideo()
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
    
    private func hideControls() {

        controlsView.stopTimer()
        controlsView.setNewState(newState: controlsView.hiddenAndPlayingState)
        
        controlsView.hideControls()
    }
    
    func videoEnded() {
        
        print("CLDVideoShownAndPlayingState - videoEnded")
        controlsView.pauseVideo()
        
        controlsView.setNewState(newState: controlsView.shownAndPausedState)
    }
}
