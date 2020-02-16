//
//  MemoDetailVC+UICollectionView.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/15.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MemoDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + self.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return UICollectionViewCell()
        }
        
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.masksToBounds = true
        
        if indexPath.item == 0 {
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.inputImageView.image = UIImage(named: "addButton")
        } else {
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
            cell.inputImageView.image = self.imageList[indexPath.item - 1]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            DispatchQueue.main.async {
                self.showAddImageSheet()
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
                return 
            }
        }
    }
}
