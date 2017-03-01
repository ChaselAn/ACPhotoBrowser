//
//  ACPhotoBrowser.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "ACPhotoBrowserCell"

protocol ACPhotoBrowserDataSource: NSObjectProtocol {

  func numberOfItems(in photoBrowser: ACPhotoBrowser) -> Int
  
  func photoBrowser(_ photoBrowser: ACPhotoBrowser, urlsForItemAt index: Int) -> String
}

class ACPhotoBrowser: UIViewController {
  //MARK: - 提供给外部的接口
  
  /// 单张网络图片的查看器，此时禁止左滑右滑，不显示索引
  ///
  /// - parameter imageUrl: 图片的url
  init(netImageUrl: String) {
    self.type = BrowserType.SingleNetImage(url: netImageUrl)
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 多张网络图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引（1/10）
  ///
  /// - parameter imageUrlList: 图片的url的数组
  init(netImageUrlList: [String]){
    self.type = BrowserType.SomeNetImages(urls: netImageUrlList)
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 单张本地图片的查看器，此时禁止左滑右滑，不显示索引
  ///
  /// - parameter image: 图片（UIImage格式）
  init(localImage: UIImage) {
    self.type = BrowserType.SingleLocalImage(img: localImage)
    super.init(nibName: nil, bundle: nil)
  }
  
  /// 多张本地图片的查看器，可以左滑右滑查看下一张上一张图片，显示索引（1/10）
  ///
  /// - parameter imageList:    图片的数组
  init(localImageList: [UIImage]) {
    self.type = BrowserType.SomeLocalImages(imgs: localImageList)
    super.init(nibName: nil, bundle: nil)
  }
  
  
  // 多张图片之间的间距
  var margin: CGFloat = 0
  // 网络图片的占位图
  var placeHolderImage: UIImage? = nil

  /// 弹出PhotoBrowser
  ///
  /// - Parameter type: PhotoBrowser弹出的方式
  /// - parameter displayIndex: （可选参数）当前显示第几张图片，默认第0张
  open func show(by type: BrowserShowType, displayIndex: Int = 0) {
    let currentVC = ACUtils.getCurrentViewController()
    self.displayIndex = displayIndex
    switch type {
    case .push(animated: let animated):
      currentVC.navigationController?.pushViewController(self, animated: animated)
    case .present(animated: let animated):
      currentVC.present(self, animated: animated)
    default:
      break
    }
  }
  
  fileprivate var imgCollectionView: UICollectionView!
  fileprivate var type: BrowserType?
  fileprivate var displayIndex: Int = 0
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


//MARK: - 暂不开放接口和属性
extension ACPhotoBrowser {
  
  fileprivate enum BrowserType {
    case SingleNetImage(url: String)
    case SomeNetImages(urls: [String])
    case SingleLocalImage(img: UIImage)
    case SomeLocalImages(imgs: [UIImage])
  }
  enum BrowserShowType {
    case push(animated: Bool)
    case present(animated: Bool)
    case animate
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: UIScreen.main.bounds.width + margin, height: UIScreen.main.bounds.height)
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    imgCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width + margin, height: UIScreen.main.bounds.height), collectionViewLayout: layout)
    imgCollectionView.register(ACPhotoBrowserCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    imgCollectionView.dataSource = self
    imgCollectionView.isPagingEnabled = true
    imgCollectionView.scrollToItem(at: IndexPath(item: displayIndex, section: 0), at: .centeredHorizontally, animated: false)
    
    view.addSubview(imgCollectionView)
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
