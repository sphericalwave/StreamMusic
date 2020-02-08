//
//  PlayButton.swift
//  AudioWave
//
//  Created by Aaron Anthony on 2020-01-26.
//  Copyright © 2020 SphericalWave. All rights reserved.
//

import UIKit

enum PlayMode {
    case play
    case pause
}

protocol PlayButtonDelegate: AnyObject { func update(mode: PlayMode) }

class PlayButton: UIButton
{
    var mode: PlayMode //FIXME: Mutable State
    weak var delegate: PlayButtonDelegate?
    let play = UIImage(systemName: "play.circle")!  //FIXME: Not great
    let pause = UIImage(systemName: "pause.circle")!
    
    required init?(coder: NSCoder) {
        self.mode = .pause
        super.init(coder: coder)
        self.addTarget(self, action: #selector(nextState), for: .touchUpInside)
        self.setImage(pause, for: .normal)
    }
    
    @objc func nextState() {
        switch mode {
        case .play:
            mode = .pause
            self.setImage(pause, for: .normal)
        case .pause:
            mode = .play
            self.setImage(play, for: .normal)
        }
        guard delegate != nil else { fatalError("Connect Delegate") }
        delegate?.update(mode: mode)
    }
}
