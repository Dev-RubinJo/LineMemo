//
//  ImageDetailVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/16.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class ImageDetailVC: BaseVC {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pagingVC: PagingVC!
    var imageList: [UIImage] = []
    var imageIndex: Int!
    
    var viewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagingVC = self.storyboard?.instantiateViewController(withIdentifier: "PagingVC") as? PagingVC
        self.pagingVC.dataSource = self
        
        for index in 0 ..< self.imageList.count {
            let vc = self.viewControllerAtIndex(index: index) as ImageContainerVC
            self.viewControllers.append(vc)
        }
                
        self.pagingVC.setViewControllers([self.viewControllers[imageIndex]] , direction: .forward, animated: true, completion: nil)
        self.pagingVC.view.frame = CGRect.init(x: 0, y: 30, width: self.view.frame.width, height: self.view.frame.height - 50)
        
        self.addChild(self.pagingVC)
        self.view.addSubview(self.pagingVC.view)
        
        self.view.bringSubviewToFront(self.dismissButton)
    }
    
    func viewControllerAtIndex(index: Int) -> ImageContainerVC {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageContainerVC") as? ImageContainerVC else { return ImageContainerVC() }
        
        vc.pageIndex = index
        vc.memoImage = self.imageList[index]
        
        return vc
    }
}

extension ImageDetailVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ImageContainerVC
        
        guard var index = vc.pageIndex else { return nil}
        
        index -= 1
        
        if index <= 0 || index == self.imageList.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ImageContainerVC
        
        guard var index = vc.pageIndex else { return nil}
        
        index += 1
        
        if index <= 0 || index == self.imageList.count {
            return nil
        }
        
        return self.viewControllerAtIndex(index: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.imageList.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
