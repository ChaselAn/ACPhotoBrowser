//
//  ACPhotoBrowserCell.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

class ACPhotoBrowserCell: UICollectionViewCell {
  
  private var imgView = UIImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imgView)
    imgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: self.bounds.height)
    imgView.contentMode = .scaleAspectFit
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setLocalImage(_ image: UIImage) {
    imgView.image = image
  }
  
  func setNetImage(_ imageUrl: String?, placeholderImage: UIImage?) {
    guard let imageUrl = imageUrl, !imageUrl.isEmpty else {
      imgView.image = UIImage(named: "ac_errorImg".ac_ImagePath)
      return
    }
    if let img = placeholderImage {
      imgView.sd_setImage(with: URL(string: imageUrl), placeholderImage: img)
    }else {
      imgView.sd_setImage(with: URL(string: imageUrl))
    }
  }
}
