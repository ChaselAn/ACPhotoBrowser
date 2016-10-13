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
  //MARK: - 提供给外部的接口
  
  /// 单张网络图片的查看器，此时禁止左滑右滑，不显示索引
  ///
  /// - parameter imageUrl: 图片的url
  init(imageUrl: String) {
    self.type = BrowserType.SingleNetImage(url: imageUrl)
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 多张网络图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引（1/10）
  ///
  /// - parameter imageUrlList: 图片的url的数组
  /// - parameter displayIndex: （可选参数）当前显示第几张图片，默认第0张
  init(imageUrlList: [String], displayIndex: Int = 0){
    self.type = BrowserType.SomeNetImages(urls: imageUrlList)
    self.displayIndex = displayIndex
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 单张本地图片的查看器，此时禁止左滑右滑，不显示索引
  ///
  /// - parameter image: 图片（UIImage格式）
  init(image: UIImage) {
    self.type = BrowserType.SingleLocalImage(img: image)
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 多张本地图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引（1/10）
  ///
  /// - parameter imageList:    图片的数组
  /// - parameter displayIndex: （可选参数）当前显示第几张图片，默认第0张
  init(imageList: [UIImage], displayIndex: Int = 0) {
    self.type = BrowserType.SomeLocalImages(imgs: imageList)
    self.displayIndex = displayIndex
    super.init(nibName: nil, bundle: nil)
  }
  
  // 多张图片之间的间距
  var margin: CGFloat = 30
  //MARK: - 暂不开放接口
  fileprivate enum BrowserType {
    case SingleNetImage(url: String)
    case SomeNetImages(urls: [String])
    case SingleLocalImage(img: UIImage)
    case SomeLocalImages(imgs: [UIImage])
  }
  
  fileprivate var imgCollectionView: UICollectionView!
  fileprivate var type: BrowserType?
  fileprivate var displayIndex = 0
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = UIScreen.main.bounds.size
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = margin
    imgCollectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
    imgCollectionView.register(ACPhotoBrowserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    imgCollectionView.dataSource = self
    imgCollectionView.delegate = self
    view.addSubview(imgCollectionView)
    
    let swipe = UISwipeGestureRecognizer(target: self, action: #selector(ACPhotoBrowser.swipeImage))
    swipe.delegate = self
    imgCollectionView.addGestureRecognizer(swipe)
    
  }
  
  @objc fileprivate func swipeImage(){
    let imgW = UIScreen.main.bounds.width + margin
    let index = Int((imgCollectionView.contentOffset.x + imgW / 2) / imgW) + 1
    imgCollectionView.setContentOffset(CGPoint(x: imgW * CGFloat(index), y: imgCollectionView.contentOffset.y), animated: true)
  }
  
}

//MARK:- dataSource
extension ACPhotoBrowser: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let type = type else {
      return 0
    }
    switch type {
    case .SomeNetImages(urls: let urls):
      return urls.count
    case .SomeLocalImages(imgs: let imgs):
      return imgs.count
    default:
      return 1
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ACPhotoBrowserCell
    guard let type = type else {
      return cell
    }
    switch type {
    case .SingleNetImage(url: let url):
      cell.imageUrl = url
    case .SingleLocalImage(img: let img):
      cell.image = img
    case.SomeNetImages(urls: let urls):
      cell.imageUrl = urls[indexPath.item]
    case .SomeLocalImages(imgs: let imgs):
      cell.image = imgs[indexPath.item]
    }
    return cell
  }
}

//MARK:- delegate
extension ACPhotoBrowser: UICollectionViewDelegate, UIGestureRecognizerDelegate{
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//    if decelerate {
//      DispatchQueue.main.async {
//        scrollView.setContentOffset(scrollView.contentOffset, animated: false)
//        let imgW = UIScreen.main.bounds.width + self.margin
//        let index = Int((scrollView.contentOffset.x + imgW / 2) / imgW)
//        scrollView.setContentOffset(CGPoint(x: imgW * CGFloat(index), y: scrollView.contentOffset.y), animated: true)
//      }
//    }
    let imgW = UIScreen.main.bounds.width + margin
    let index = Int((scrollView.contentOffset.x + imgW / 2) / imgW)
    scrollView.setContentOffset(CGPoint(x: imgW * CGFloat(index), y: scrollView.contentOffset.y), animated: true)
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
  
}
