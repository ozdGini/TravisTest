//
//  CLDVideoHiddenAndPausedState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import UIKit

class CLDVideoHiddenAndPausedState: NSObject, CLDVideoControlsState {
    
    var controlsView: CLDVideoControlsView
    
    required init(controlsView: CLDVideoControlsView) {
        self.controlsView = controlsView
        super.init()
    }
    
    func playPausePressed() {
        print("shouldn't be called in this state")
    }
    
    func backgroundPressed() {
        print("CLDVideoHiddenAndPausedState - backgroundPressed")

        self.controlsView.setNewState(newState: self.controlsView.shownAndPausedState)
        self.controlsView.stopTimer()
        
        UIView.animate(withDuration: 0.2, animations: {
            self.controlsView.showControls()
        })
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        print("shouldn't be called in this state")
    }
}
