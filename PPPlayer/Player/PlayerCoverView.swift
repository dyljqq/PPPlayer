//
//  PlayerControlView.swift
//  PPPlayer
//
//  Created by 季勤强 on 2018/6/28.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import UIKit

class PlayerCoverView: UIView {
  
  var play: Bool = false {
    didSet {
      controlImageView.image = UIImage(named: play ? "play" : "pause")
    }
  }
  
  var playClosure: ((Bool) -> ())?
  
  lazy var coverView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    return view
  }()
  
  lazy var controlImageView: UIImageView = {
    let imageView = UIImageView(frame: CGRect.zero)
    imageView.image = UIImage(named: "pause")
    imageView.isUserInteractionEnabled = true
    
    let tap = UITapGestureRecognizer(target: self, action: #selector(controlImageTapped))
    imageView.addGestureRecognizer(tap)
    
    return imageView
  }()
  
  init() {
    super.init(frame: CGRect.zero)
    
    setup()
  }
  
  func show() {
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 1.0
    })
  }
  
  func hide() {
    UIView.animate(withDuration: 0.3, animations: {
      self.alpha = 0.0
    })
  }
  
  @objc func controlImageTapped() {
    play = !play
    if let closure = playClosure {
      closure(play)
    }
  }
  
  private func setup() {
    addSubview(self.coverView)
    addSubview(self.controlImageView)
    
    self.coverView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    self.controlImageView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
