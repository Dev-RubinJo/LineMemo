//
//  MemoDetailVC+UIImagePickerController.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/16.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MemoDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageList.append(image)
            self.tempImageList.append(image)
            
        } else {
            print("error")
        }
        dismiss(animated: true, completion: nil)
    }
}
