//
//  CLDVideoControlsState.swift
//  CLDVideoView
//
//  Created by Oz Deutsch on 25/10/2020.
//  Copyright © 2020 Cloudinary. All rights reserved.
//

import Foundation

protocol CLDVideoControlsState: class {
    
    var controlsView: CLDVideoControlsView { get set }
    
    init(controlsView: CLDVideoControlsView)
    
    func playPausePressed()
    func backgroundPressed()
    func timerFinished()
    func videoEnded()
}
