//
//  DownloadButtons.swift
//  AudioWave
//
//  Created by Aaron Anthony on 2020-01-26.
//  Copyright © 2020 SphericalWave. All rights reserved.
//

import UIKit

class DownloadButtons: UIViewController
{
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!    //FIXME: Break Into Component Objects
    @IBOutlet weak var pauseButton: PlayButton!
    
    let download: URLSessionDownloadTask
    
    init(download: URLSessionDownloadTask) {
        self.download = download
        super.init(nibName: "DownloadButtons", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError() }
    
    @IBAction func cancelTapped() {
        //track.cancelDownload()
        //pauseButton.setTitle("Resume", for: .normal)
        downloadButton.isHidden = false
        pauseButton.isHidden = true
        cancelButton.isHidden = false
    }
    
    @IBAction func downloadTapped() {
        //track.startDownload()
        downloadButton.isHidden = true
        pauseButton.isHidden = false
        cancelButton.isHidden = false
    }
    
    @IBAction func pauseOrResumeTapped() {
        //FIXME: Toggle Behavior Belongs inside a decorated UIButton
        //if ()
        // guard let play = UIImage(systemName: "play.circle") else { fatalError() }
        // pauseButton.setImage(play, for: .normal)
        //track.pauseDownload()
        //}
        //else {
        //track.resumeDownload()
        //}
    }
    
    //FIXME: Push Hidding Behavior into Buttons
    func update() {
        switch download.state {
        case .running:
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
        case .suspended:
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
        case .canceling:
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
        case .completed:
            downloadButton.isHidden = true
            pauseButton.isHidden = false
            cancelButton.isHidden = false
        default:
            fatalError()
        }
    }
}
