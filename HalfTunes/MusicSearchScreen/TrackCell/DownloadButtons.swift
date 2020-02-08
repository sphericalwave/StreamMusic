//
//  DownloadButtons.swift
//  AudioWave
//
//  Created by Aaron Anthony on 2020-01-26.
//  Copyright © 2020 SphericalWave. All rights reserved.
//

import UIKit

protocol DownloadButtonsDelegate: AnyObject {
    func download2()    //FIXME:
    func pause()
    func resume()
    func cancel()
}

class DownloadButtons: UIViewController
{
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var pauseButton: PlayButton!
    weak var delegate: DownloadButtonsDelegate?
    
    init() { super.init(nibName: "DownloadButtons", bundle: nil) }
    required init?(coder: NSCoder) { fatalError() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.delegate = self
    }
    
    @IBAction func cancelTapped() { delegate?.cancel()
//        downloadButton.isHidden = false
//        pauseButton.isHidden = true
//        cancelButton.isHidden = false
    }
    
    @IBAction func downloadTapped() {
        delegate?.download2()
//        downloadButton.isHidden = true
//        pauseButton.isHidden = false
//        cancelButton.isHidden = false
    }
    
//    @IBAction func pauseOrResumeTapped() {
//
//        //FIXME: Toggle Behavior Belongs inside a decorated UIButton
//        //if ()
//        // guard let play = UIImage(systemName: "play.circle") else { fatalError() }
//        // pauseButton.setImage(play, for: .normal)
//        //track.pauseDownload()
//        //}
//        //else {
//        //track.resumeDownload()
//        //}
//    }
    
    //FIXME: Push Hidding Behavior into Buttons
    func update() {
//        switch download.state {
//        case .running:
//            downloadButton.isHidden = true
//            pauseButton.isHidden = false
//            cancelButton.isHidden = false
//        case .suspended:
//            downloadButton.isHidden = true
//            pauseButton.isHidden = false
//            cancelButton.isHidden = false
//        case .canceling:
//            downloadButton.isHidden = true
//            pauseButton.isHidden = false
//            cancelButton.isHidden = false
//        case .completed:
//            downloadButton.isHidden = true
//            pauseButton.isHidden = false
//            cancelButton.isHidden = false
//        default:
//            fatalError()
//        }
    }
}

extension DownloadButtons: PlayButtonDelegate
{
    func update(mode: PlayMode) {
        switch mode {
        case .play:
            print("resume downloading")
            delegate?.resume()
        case .pause:
            print("pause downloading")
            delegate?.pause()
        }
    }
}
