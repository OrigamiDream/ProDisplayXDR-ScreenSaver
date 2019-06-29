//
//  ProDisplayXDRView.swift
//  Pro Display XDR ScreenSaver
//
//  Created by OrigamiDream on 29/06/2019.
//  Copyright © 2019 Avis Studio. All rights reserved.
//

import Cocoa
import ScreenSaver
import AVKit
import AVFoundation
import MediaPlayer

class ProDisplayXDRView: ScreenSaverView {
    
    let controller = AVPlayerView()
    var player: AVPlayer!
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        let bundle = Bundle(for: type(of: self));
        guard let path = bundle.path(forResource: "ProDisplayXDR", ofType: "mp4", inDirectory: "") else {
            let string = NSAttributedString(string: "Unknown path", attributes: [
                .foregroundColor: NSColor.white
            ])
            string.draw(at: NSPoint(x: 100, y: 100))
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resize
        layer.frame = bounds
        self.layer?.addSublayer(layer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            self.player.seek(to: CMTime.zero)
            self.player.play()
        }
        player.play()
    }
    
}
