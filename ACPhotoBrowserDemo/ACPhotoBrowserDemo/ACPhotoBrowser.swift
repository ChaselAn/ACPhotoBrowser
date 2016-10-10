//
//  ACPhotoBrowser.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 16/10/10.
//  Copyright © 2016年 ac. All rights reserved.
//

import UIKit

protocol ACPhotoBrowserDelegate: NSObjectProtocol {
  //图片数组的数量
  func numberOfImages(_ photoBrowser: ACPhotoBrowser) -> Int
}

fileprivate let reuseIdentifier = "ACPhotoBrowserCell"
class ACPhotoBrowser: UIViewController {
  fileprivate var imgCollectionView: UICollectionView!
  weak var delegate: ACPhotoBrowserDelegate!
  
  init(delegate: ACPhotoBrowserDelegate) {
    self.delegate = delegate
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

}

extension ACPhotoBrowser: UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return delegate.numberOfImages(self)
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ACPhotoBrowserCell
    return cell
  }
}
