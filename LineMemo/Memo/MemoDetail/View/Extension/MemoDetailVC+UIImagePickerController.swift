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
            if let memo = self.memoData {
                guard let imageData = image.jpegData(compressionQuality: 0.3) else { self.dismiss(animated: true, completion: nil)
                    return
                }
                self.actor?.appendImageToMemo(memo: memo, image: imageData)
            }
        } else {
            print("error")
        }
        dismiss(animated: true, completion: nil)
    }
}
