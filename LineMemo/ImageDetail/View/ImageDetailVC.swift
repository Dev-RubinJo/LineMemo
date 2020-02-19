//
//  ImageDetailVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/16.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class ImageDetailVC: BaseVC, BaseVCProtocol {
    
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
        self.initVC()
    }
    
    func initVC() {
        self.setImageDetailVCUI()
    }
    
    func viewControllerAtIndex(index: Int) -> ImageContainerVC {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ImageContainerVC") as? ImageContainerVC else { return ImageContainerVC() }
        
        vc.pageIndex = index
        vc.memoImage = self.imageList[index]
        
        return vc
    }
}

