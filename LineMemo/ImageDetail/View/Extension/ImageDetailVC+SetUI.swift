//
//  ImageDetailVC+SetUI.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/19.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension ImageDetailVC {
    func setImageDetailVCUI() {
        self.pagingVC = self.storyboard?.instantiateViewController(withIdentifier: "PagingVC") as? PagingVC
        self.pagingVC.dataSource = self
        self.pagingVC.delegate = self
        
        for index in 0 ..< self.imageList.count {
            let vc = self.viewControllerAtIndex(index: index) as ImageContainerVC
            self.viewControllers.append(vc)
        }
        
        self.pagingVC.setViewControllers([self.viewControllers[imageIndex]] , direction: .forward, animated: true, completion: nil)
        self.pagingVC.view.frame = CGRect.init(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        self.addChild(self.pagingVC)
        self.view.addSubview(self.pagingVC.view)
        
        self.pageControl.numberOfPages = self.viewControllers.count
        self.pageControl.currentPage = self.imageIndex
        
        self.view.bringSubviewToFront(self.dismissButton)
    }
}
