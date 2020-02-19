//
//  ImageDetailVC+UIPageViewControllerDelegate+UIPageViewControllerDataSource.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/19.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension ImageDetailVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0] as! ImageContainerVC
        let index = pageContentViewController.pageIndex
        
        self.pageControl.currentPage = index!
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ImageContainerVC
        guard var index = vc.pageIndex else { return nil}
        index -= 1
        if index < 0 || index == self.imageList.count {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ImageContainerVC
        guard var index = vc.pageIndex else { return nil}
        index += 1
        if index < 0 || index == self.imageList.count {
            return nil
        }
        return self.viewControllerAtIndex(index: index)
    }
}
