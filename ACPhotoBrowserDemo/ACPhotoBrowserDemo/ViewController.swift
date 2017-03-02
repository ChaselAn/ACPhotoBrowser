//
//  ViewController.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
  
  fileprivate var imgList: [String] = ["http://7xte1z.com1.z0.glb.clouddn.com/slider1.png",
                                       "http://7xte1z.com1.z0.glb.clouddn.com/slider2.jpg",
                                       "http://7xte1z.com1.z0.glb.clouddn.com/slider3.jpg"]
  
  var browser = ACPhotoBrowser()
  
  override init(collectionViewLayout layout: UICollectionViewLayout) {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 100)
    super.init(collectionViewLayout: layout)
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ACCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    browser.dataSource = self
    browser.margin = 20
  }

}

extension ViewController{
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imgList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACCollectionViewCell
    cell.setInfo(url: imgList[indexPath.item])
    cell.jumpBrowser = { [weak self] in
      guard let strongSelf = self else {
        return
      }
      strongSelf.browser.show(by: .push(animated: true), displayIndex: indexPath.row)
    }
    return cell
  }
}

extension ViewController: ACPhotoBrowserDataSource {
  func numberOfImages(in photoBrowser: ACPhotoBrowser) -> Int {
    return imgList.count
  }
  
  func photoBrowser(_ photoBrowser: ACPhotoBrowser, netImageUrlAt index: Int) -> String {
    return imgList[index]
  }
}
