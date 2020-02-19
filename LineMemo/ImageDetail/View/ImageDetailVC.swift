//
//  ImageDetailVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/16.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class ImageDetailVC: BaseVC {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var dismissButton: UIButton!
    
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pagingVC: PagingVC!
    var imageList: [UIImage] = []
    var imageIndex: Int!
    let pageControlHeight: CGFloat = 20
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagingVC = self.storyboard?.instantiateViewController(withIdentifier: "PagingVC") as? PagingVC
        self.pagingVC.dataSource = self
        self.pagingVC.delegate = self
        
        for index in 0 ..< self.imageList.count {
            let vc = self.viewControllerAtIndex(index: index) as ImageContainerVC
            self.viewControllers.append(vc)
        }
    
        self.pagingVC.setViewControllers([self.viewControllers[imageIndex]] , direction: .forward, animated: true, completion: nil)
//        self.pagingVC.indicator.
        self.pagingVC.view.frame = CGRect.init(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        self.addChild(self.pagingVC)
        self.view.addSubview(self.pagingVC.view)
        
        self.pageControl.numberOfPages = self.viewControllers.count
        self.pageControl.currentPage = self.imageIndex
        
        self.view.bringSubviewToFront(self.dismissButton)
    }
    
    func viewControllerAtIndex(index: Int) -> ImageContainerVC {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageContainerVC") as? ImageContainerVC else { return ImageContainerVC() }
        
        vc.pageIndex = index
        vc.memoImage = self.imageList[index]
        
        return vc
    }
}

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
