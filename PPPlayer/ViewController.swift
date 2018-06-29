//
//  ViewController.swift
//  PPPlayer
//
//  Created by 季勤强 on 2018/6/28.
//  Copyright © 2018年 dyljqq. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let playerView = PlayerView()
    view.addSubview(playerView)
    
    playerView.snp.makeConstraints { make in
      make.height.equalTo(200)
      make.leading.equalToSuperview()
      make.center.equalToSuperview()
    }
    
    playerView.config(urlString: "https://cloud.video.taobao.com/play/u/3375170974/p/1/e/6/t/1/50067220605.mp4")
  }

}

