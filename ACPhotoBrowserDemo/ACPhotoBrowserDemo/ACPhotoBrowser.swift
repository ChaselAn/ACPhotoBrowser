//
//  ACPhotoBrowser.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "ACPhotoBrowserCell"
class ACPhotoBrowser: UIViewController {
  fileprivate var imgCollectionView: UICollectionView!
  
  fileprivate enum BrowserType {
    case SingleNetImage(url: String)
    case SomeNetImages(urls: [String])
    case SingleLocalImage(img: UIImage)
    case SomeLocalImages(imgs: [UIImage])
  }
  
//  fileprivate var imageUrl = ""
//  fileprivate var imageUrlList: [String] = []
//  fileprivate var image: UIImage = UIImage()
//  fileprivate var imageList: [UIImage] = []
  fileprivate var type: BrowserType?

  // 单张网络图片的查看器，此时禁止左滑右滑，不显示索引（1/10）
  init(imageUrl: String) {
    self.type = BrowserType.SingleNetImage(url: imageUrl)
    super.init(nibName: nil, bundle: nil)
  }
  
  // 多张网络图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引
  init(imageUrlList: [String]){
    self.type = BrowserType.SomeNetImages(urls: imageUrlList)
    super.init(nibName: nil, bundle: nil)
  }
  
  // 单张本地图片的查看器，此时禁止左滑右滑，不显示索引（1/10）
  init(image: UIImage) {
    self.type = BrowserType.SingleLocalImage(img: image)
    super.init(nibName: nil, bundle: nil)
  }
  
  // 多张本地图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引
  init(imageList: [UIImage]) {
    self.type = BrowserType.SomeLocalImages(imgs: imageList)
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    imgCollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    imgCollectionView.register(ACPhotoBrowserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    view.addSubview(imgCollectionView)
  }
  
  func show() {
    
  }

}

extension ACPhotoBrowser: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ACPhotoBrowserCell
    return cell
  }
}
