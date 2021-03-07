//
//  PlayVideoViewController.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 2/25/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: UIViewController ,YTPlayerViewDelegate{

    
    @IBOutlet weak var playView: YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
         let url = URL(string: "www.youtube.com/channel/UCG5qGWdu8nIRZqJ_GgDwQ-w")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)

        /*
        playView.delegate = self
        // playerView.load(withVideoId: "73WVVKy7Abw")
        playView.load(withVideoId:"5hcHbhIWIeI",
                        playerVars: ["playinline":1])
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playView.playVideo()      //auto play
    }
  */
 
}
}
