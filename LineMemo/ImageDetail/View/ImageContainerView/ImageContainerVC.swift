//
//  ImageContainerVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/16.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class ImageContainerVC: UIViewController {
    
    @IBOutlet weak var memoImageView: UIImageView!
    
    var pageIndex: Int!
    var memoImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memoImageView.image = self.memoImage
    }
}
