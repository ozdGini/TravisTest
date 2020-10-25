//
//  CLDVideoHiddenAndPlayingState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import UIKit

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
        
        UIView.animate(withDuration: 0.2, animations: {
            
            // we dont set the background alphe to 0 in order to keep getting touch events
            self.controlsView.backgroundColor       = self.controlsView.transparentBackgroundColor
            self.controlsView.playPauseButton.alpha = 1.0
            
        }) { _ in
            
            self.controlsView.setNewState(newState: self.controlsView.shownAndPlayingState)
            self.controlsView.startTimer()
        }
    }
    
    func timerFinished() {
        print("shouldn't be called in this state")
    }
    
    func videoEnded() {
        
        controlsView.playPauseButton.setTitle("▶", for: .normal)
        
        UIView.animate(withDuration: 0.2, animations: {
            
            self.controlsView.showControls()
            
        }) { _ in
            
            self.controlsView.setNewState(newState: self.controlsView.shownAndPausedState)
            self.controlsView.stopTimer()
        }
    }
}
