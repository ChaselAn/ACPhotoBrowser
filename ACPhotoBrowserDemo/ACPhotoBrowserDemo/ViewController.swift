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
  
  required init?(coder aDecoder: NSCoder) {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: 100, height: 100)
    super.init(collectionViewLayout: layout)
    collectionView?.backgroundColor = UIColor.white
    collectionView?.register(ACCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

}

extension ViewController{
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return imgList.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ACCollectionViewCell
    cell.setInfo(url: imgList[indexPath.item])
    return cell
  }
}
