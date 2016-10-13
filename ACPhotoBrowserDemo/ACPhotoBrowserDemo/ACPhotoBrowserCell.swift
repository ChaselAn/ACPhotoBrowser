//
//  ACPhotoBrowserCell.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

class ACPhotoBrowserCell: UICollectionViewCell {
  fileprivate var imgView = UIImageView()
  
  var imageUrl: String?{
    didSet{
      imgView.sd_setImage(with: URL(string: imageUrl!))
    }
  }
  var image: UIImage?{
    didSet{
      imgView.image = image!
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(imgView)
    imgView.frame = contentView.frame
    imgView.contentMode = .scaleAspectFit
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
