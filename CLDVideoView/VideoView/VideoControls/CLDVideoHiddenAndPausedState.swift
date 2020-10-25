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
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.controlsView.showControls()
            
        }) { _ in
            
            self.controlsView.setNewState(newState: self.controlsView.shownAndPausedState)
            self.controlsView.stopTimer()
        }
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        print("shouldn't be called in this state")
    }
}
