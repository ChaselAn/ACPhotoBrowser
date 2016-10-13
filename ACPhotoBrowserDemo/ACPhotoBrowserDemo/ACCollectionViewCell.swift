//
//  ACCollectionViewCell.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit
import SDWebImage

class ACCollectionViewCell: UICollectionViewCell {
  
  fileprivate lazy var imgView = UIImageView()
  var jumpBrowser: (()->())?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imgView)
    imgView.frame = contentView.frame
    imgView.isUserInteractionEnabled = true
    let tap = UITapGestureRecognizer(target: self, action: #selector(ACCollectionViewCell.tap))
    imgView.addGestureRecognizer(tap)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setInfo(url: String){
    imgView.sd_setImage(with: URL(string: url))
  }
  
  @objc fileprivate func tap(){
    jumpBrowser?()
  }
}
