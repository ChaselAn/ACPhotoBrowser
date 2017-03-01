//
//  ACUtils.swift
//  ACPhotoBrowserDemo
//
//  Created by ancheng on 2017/1/12.
//  Copyright © 2017年 ac. All rights reserved.
//
import UIKit

class ACUtils {
  class func getCurrentViewController(_ vc:UIViewController =  UIApplication.shared.keyWindow!.rootViewController!) -> UIViewController {
    
    if vc.presentedViewController != nil {
      return getCurrentViewController(vc.presentedViewController!)
    } else if let svc = vc as? UISplitViewController {
      if svc.viewControllers.count > 0 {
        return getCurrentViewController(svc.viewControllers.last!)
      } else {
        return vc
      }
    } else if let nvc = vc as? UINavigationController {
      if nvc.viewControllers.count > 0 {
        return getCurrentViewController(nvc.topViewController!)
      } else {
        return vc
      }
    } else if let tvc = vc as? UITabBarController {
      if tvc.viewControllers!.count > 0 {
        return getCurrentViewController(tvc.selectedViewController!)
      } else {
        return vc
      }
    } else {
      return vc
    }
  }
}
