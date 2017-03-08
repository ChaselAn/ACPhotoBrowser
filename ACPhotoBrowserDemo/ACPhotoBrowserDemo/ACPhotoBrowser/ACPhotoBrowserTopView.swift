//
//  ACPhotoBrowserTopView.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 2017/3/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACPhotoBrowserTopView: UIView {

  var TopViewHeight: CGFloat = 50
  var isHaveBackButton = true {
    didSet {
      backButton.isHidden = !isHaveBackButton
    }
  }
  
  private var backButton = ACBackButton()
  weak var handleVC: ACPhotoBrowser!
  var indexLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: CGRect.zero)
    setupUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    backButton.setImage(UIImage(named: "ac_backArrow".ac_ImagePath), for: .normal)
    backButton.setTitle("返回", for: .normal)
    backButton.adjustsImageWhenHighlighted = false
    backButton.frame = CGRect(x: 20, y: 5, width: 80, height: 25)
    backButton.addTarget(self, action: #selector(clickBackBtn), for: .touchUpInside)
    addSubview(backButton)
    
    indexLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 30)
    indexLabel.center.y = backButton.center.y
    indexLabel.textAlignment = .center
    indexLabel.textColor = UIColor.white
    indexLabel.font = UIFont.systemFont(ofSize: 20)
    addSubview(indexLabel)
  }
  
  @objc private func clickBackBtn() {
    handleVC.hide()
  }
}
