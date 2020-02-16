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
        
        if let memo = self.memoData {
            let editButton = UIBarButtonItem(title: "edit", style: .plain, target: self, action: #selector(self.pressEditButtonItem(_:)))
            self.navigationItem.rightBarButtonItem = editButton
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
    
    @objc func pressAddButtonItem(_ sender: UIBarButtonItem) {
        let id = UserDefaults.standard.integer(forKey: "memoIdNumber")
        print(id)
        guard let title = self.memoDetailTitleTextField.text else {
            return
        }
        if title.isEmpty {
            self.presentAlert(title: "제목은 필수 입력입니다!", message: "제목은 필수 입력이니 입력해주세요!")
            return
        }
        let memo = Memo(id: id, title: self.memoDetailTitleTextField.text!, content: self.memoDetailContentTextView.text, imageList: [])
        UserDefaults.standard.set(id + 1, forKey: "memoIdNumber")
        self.actor?.didTapAddButtonItem(memo: memo)
        for image in self.tempImageList {
            guard let imageData = image.jpegData(compressionQuality: 0.3) else { 
                return
            }
            self.actor?.appendImageToMemo(memo: memo, image: imageData)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pressEditButtonItem(_ sender: UIBarButtonItem) {
        for image in self.tempImageList {
            if let memo = self.memoData {
                guard let imageData = image.jpegData(compressionQuality: 0.3) else { self.dismiss(animated: true, completion: nil)
                    return
                }
                self.actor?.appendImageToMemo(memo: memo, image: imageData)
            }
        }
        let title = self.memoDetailTitleTextField.text!
        let content = self.memoDetailContentTextView.text!
        self.actor?.didTapEditButtonItem(memo: self.memoData!, title: title, content: content)
        self.navigationController?.popViewController(animated: true)
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
