//
//  MemoDetailVC+SetUI.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

extension MemoDetailVC {
    func setMemoDetailUI() {
        let imageCellNib = UINib.init(nibName: "ImageCell", bundle: nil)
        self.memoDetailImageCollectionView.register(imageCellNib, forCellWithReuseIdentifier: "ImageCell")
        
        let longPressGestureForDelete = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressGestureForDeleteImage(_:)))
        longPressGestureForDelete.minimumPressDuration = 0.5
        self.memoDetailImageCollectionView.addGestureRecognizer(longPressGestureForDelete)
        
        if let memo = self.memoData {
            let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(self.pressEditButtonItem(_:)))
            let deleteButton = UIBarButtonItem(title: "del", style: .plain, target: self, action: #selector(self.pressDeleteButton(_:)))
            self.navigationItem.rightBarButtonItems = [deleteButton, editButton]
            self.memoDetailTitleTextField.text = memo.title
            self.memoDetailContentTextView.text = memo.content
        } else {
            let addButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(self.pressAddButtonItem(_:)))
            self.navigationItem.rightBarButtonItem = addButton
            self.setMemoDetailTextView(self.memoDetailContentTextView)
        }
    }
    
    // MARK: long press Gesture
    @objc func longPressGestureForDeleteImage(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
        case .began:
            guard let selectedIndexPath = self.memoDetailImageCollectionView.indexPathForItem(at: gesture.location(in: self.memoDetailImageCollectionView)) else { return }
            
            self.imageIndex = selectedIndexPath.item
        case .ended:
            fallthrough
        default:
            self.memoDetailImageCollectionView.reloadData()
        }
    }
    
    @objc func pressAddButtonItem(_ sender: UIBarButtonItem) {
        let id = UserDefaults.standard.integer(forKey: "memoIdNumber")
        var content: String = ""
        guard let title = self.memoDetailTitleTextField.text else {
            return
        }
        if title.isEmpty {
            self.presentAlert(title: "제목은 필수 입력입니다!", message: "제목은 필수 입력이니 입력해주세요!")
            return
        }
        if self.memoDetailContentTextView.text == "내용을 입력해주세요" {
            content = ""
        } else {
            content = self.memoDetailContentTextView.text
        }
        let memo = Memo(id: id, title: title, content: content, imageList: [])
        UserDefaults.standard.set(id + 1, forKey: "memoIdNumber")
        self.actor?.didTapAddButtonItem(memo: memo)
        for image in self.imageList {
            if let imageData = image.jpegData(compressionQuality: 0.3) {
                self.actor?.appendImageToMemo(memo: memo, image: imageData)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressEditButtonItem(_ sender: UIBarButtonItem) {
        let title = self.memoDetailTitleTextField.text!
        let content = self.memoDetailContentTextView.text!
        self.actor?.didTapEditButtonItem(memo: self.memoData!, title: title, content: content)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressDeleteButton(_ sender: UIBarButtonItem) {
        self.actor?.presentDeleteMemoAlert(toVC: self)
    }
}
