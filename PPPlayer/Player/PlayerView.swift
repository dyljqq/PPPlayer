//
//  PlayerView.swift
//  PPPlayer
//
//  Created by 季勤强 on 2018/6/28.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import UIKit

class PlayerView: UIView {
  
  lazy var playerView: Player = {
    let playerView = Player()
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.playerViewTapped))
    playerView.isUserInteractionEnabled = true
    playerView.addGestureRecognizer(tap)
    return playerView
  }()
  
  lazy var coverView: PlayerCoverView = {
    let coverView = PlayerCoverView()
    return coverView
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func config(urlString: String) {
    playerView.config(urlString: urlString)
  }
  
  func play() {
    coverView.hide()
    coverView.play = true
    playerView.play()
  }
  
  @objc func playerViewTapped() {
    coverView.play = false
    coverView.show()
    playerView.pause()
  }
  
  private func setup() {
    addSubview(playerView)
    addSubview(coverView)
    
    playerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    coverView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    coverView.playClosure = { [unowned self] play in
      self.play()
    }
  }
  
}
