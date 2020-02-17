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
            
            // TODO: 다크모드 라이트모드 전환시 placeholder 색상이 바로 안바뀌는 이유 찾기
            // FIXME: 다크모드 라이트모드 전환시 placeholder 색상이 바로 안바뀌는 이슈 해결하기
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
    
    /// 사진 불러올 때의 액션시트 띄우기 함수
    func showAddImageSheet() {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 카메라 액션
        let fromCameraAction = UIAlertAction(title: "카메라로 사진찍기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: false, completion: nil)
            }
        }
        // 앨범 액션
        let fromAlbumAction = UIAlertAction(title: "앨범에서 사진 가져오기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.mediaTypes = ["public.image"]
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            }
        }
        // URL로 사진 가져오기 액션
        let fromURLAction = UIAlertAction(title: "URL로 사진 가져오기", style: .default) { _ in
            self.actor?.presentGetUrlAlert(toVC: self)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        addImageActionSheet.addAction(fromCameraAction)
        addImageActionSheet.addAction(fromAlbumAction)
        addImageActionSheet.addAction(fromURLAction)
        addImageActionSheet.addAction(cancelAction)
        
        self.present(addImageActionSheet, animated: true, completion: nil)
    }
}
