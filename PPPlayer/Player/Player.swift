//
//  Player.swift
//  PPPlayer
//
//  Created by 季勤强 on 2018/6/28.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import UIKit
import AVFoundation

private var playerViewControllerKVOContext = 0

enum PlayerState {
  case buffering
  case readyToPlay
  case playerToTheEnd
  case failed
}

class Player: UIView {
  
  let player = AVPlayer()
  
  lazy var playerLayer: AVPlayerLayer = {
    return AVPlayerLayer(player: self.player)
  }()
  
  var playerItem: AVPlayerItem? {
    didSet {
      player.replaceCurrentItem(with: self.playerItem)
    }
  }
  
  var asset: AVURLAsset? {
    didSet {
      guard let newAsset = asset else { return }
      playerItem = AVPlayerItem(asset: newAsset)
    }
  }
  
  private var state: PlayerState = .buffering
  
  init() {
    super.init(frame: CGRect.zero)
    
    setup()
  }
  
  func config(urlString: String) {
    guard let url = URL(string: urlString) else { return }
    asset = AVURLAsset(url: url)
    
    NotificationCenter.default.addObserver(self, selector: #selector(didEndPlay), name: Notification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
    playerItem?.addObserver(self, forKeyPath: "status", options: [.new], context: &playerViewControllerKVOContext)
  }
  
  func play() {
    if self.state == .playerToTheEnd {
      player.seek(to: CMTimeMake(0, 1), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    }
    player.play()
  }
  
  func pause() {
    player.pause()
  }
  
  @objc func didEndPlay() {
    self.state = .playerToTheEnd
    print("did end pay...")
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    guard context == &playerViewControllerKVOContext else { return }
    if keyPath == "status" {
      
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.addSublayer(playerLayer)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    playerLayer.frame = self.bounds
  }
  
  deinit {
    playerItem?.removeObserver(self, forKeyPath: "status", context: &playerViewControllerKVOContext)
  }
  
}
