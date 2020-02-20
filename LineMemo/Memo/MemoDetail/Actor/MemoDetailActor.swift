//
//  MemoDetailActor.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit
// url 이미지를 가져올 때 추후 관리의 편의성을 위해 이미지를 다운로드 하고자
// Alamofire, AlamofireImage 사용
import Alamofire
import AlamofireImage

class MemoDetailActor: MemoDetailActorDelegate {
    
    static let shared = MemoDetailActor()
    private init() {}
    
    weak var view: MemoDetailVCRouterDelegate?
    
    func appendImageToMemo(memo: Memo, image: Data) {
        MemoModel.shared.addImage(memo: memo, imageData: image)
    }
    
    func didTapAddButtonItem(memo: Memo) {
        MemoModel.shared.addNewMemo(newMemo: memo)
    }
    
    func didTapEditButtonItem(memo: Memo, title: String, content: String) {
        MemoModel.shared.editMemo(memo: memo, title: title, content: content)
    }
    
    func presentDeleteMemoAlert(toVC vc: MemoDetailVC) {
        let deleteAction = UIAlertAction(title: "삭제하기", style: .default) { _ in
            guard let memo = vc.memoData else { return }
            guard let index = vc.memoIndex else { return }
            
            self.didTapDeleteButtonItem(memo: memo, index: index)
            vc.navigationController?.popViewController(animated: true)
        }
        
        vc.presentAlertWithAction(title: "정말로 삭제하실껀가요?", message: "맞다면 삭제하기 버튼을 눌러주세요!", deleteAction)
    }
    
    /// 사진 불러올 때의 액션시트 띄우기 함수
    func showAddImageSheet(toVC vc: MemoDetailVC) {
        let addImageActionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 카메라 액션
        let fromCameraAction = UIAlertAction(title: "카메라로 사진찍기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                vc.imagePicker.sourceType = .camera
                self.view?.presentImagePickerController(targetVC: vc.imagePicker)
            }
        }
        // 앨범 액션
        let fromAlbumAction = UIAlertAction(title: "앨범에서 사진 가져오기", style: .default) { _ in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                vc.imagePicker.sourceType = .photoLibrary
                vc.imagePicker.mediaTypes = ["public.image"]
                vc.imagePicker.modalPresentationStyle = .fullScreen
                self.view?.presentImagePickerController(targetVC: vc.imagePicker)
            }
        }
        // URL로 사진 가져오기 액션
        let fromURLAction = UIAlertAction(title: "URL로 사진 가져오기", style: .default) { _ in
            vc.actor?.presentGetUrlAlert(toVC: vc)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        addImageActionSheet.addAction(fromCameraAction)
        addImageActionSheet.addAction(fromAlbumAction)
        addImageActionSheet.addAction(fromURLAction)
        addImageActionSheet.addAction(cancelAction)
        
        vc.present(addImageActionSheet, animated: true, completion: nil)
    }
    
    func presentGetUrlAlert(toVC vc: MemoDetailVC) {
        let alertWithUrlTextField = UIAlertController(title: "URL을 입력해주세요!", message: "가져오고 싶은 사진의 URL을 입력해주세요!", preferredStyle: .alert)
        alertWithUrlTextField.addTextField { textField in
            let clipboardString = UIPasteboard.general.string
            if let urlString = clipboardString {
                textField.text = urlString
            } else {
                textField.placeholder = "URL을 입력해주세요!"
            }
        }
        let doneAction = UIAlertAction(title: "가져오기", style: .default) { _ in
            self.getImageFromURL(url: (alertWithUrlTextField.textFields?[0].text)!, vc: vc)
        }
        let cancelAction = UIAlertAction(title: "취소", style: .destructive)
        
        alertWithUrlTextField.addAction(cancelAction)
        alertWithUrlTextField.addAction(doneAction)
        
        vc.present(alertWithUrlTextField, animated: true, completion: nil)
    }
    
    // 이미지 삭제를 위한 long press gesture에서 띄울 Alert
    func presentDeleteImageAlert(toVC vc: MemoDetailVC, memo: Memo, imageIndex: Int) {
        // TODO: 수정을 할 때 해당 기능으로 이미지 삭제하면 무조건 삭제가 된다. 기능을 추 후에 다시 검토할것
        let deleteAction = UIAlertAction(title: "삭제하기", style: .default) { _ in
            vc.imageList.remove(at: imageIndex - 1)
            if !memo.imageList.isEmpty {
                MemoModel.shared.removeMemoImage(memo: memo, imageIndex: imageIndex - 1)
            }
            vc.memoDetailImageCollectionView.reloadData()
        }
        vc.presentAlertWithAction(title: "이미지 삭제", message: "이미지를 삭제하시려면 삭제하기를 눌러주세요!", deleteAction)
    }
    
    func didTapImageCell(fromVC vc: MemoDetailVC, imageIndex: Int) {
        
        self.view?.presentImageDetailVC(fromVC: vc, imageIndex: imageIndex)
    }
}
extension MemoDetailActor {
    
    /// 해당 메서드는 삭제 버튼을 눌렀을 때 바로 작동하는 메서드가 아니므로 delegate 메서드가 아님
    fileprivate func didTapDeleteButtonItem(memo: Memo, index: Int) {
        MemoModel.shared.deleteMemo(targetMemo: memo, index: index)
    }
    
    /// 이미지를 가져오는 행위를 하는 함수 따로 정의(not delegate func)
    /// Network로 따로 나누지 않은 이유 -> API호출이 아니고, response에 따라 분기가 많아지는 것이 아닌 2가지 경우밖에 없기 때문
    fileprivate func getImageFromURL(url: String, vc: MemoDetailVC) {
        // 프로그래머스 기능 명세에 `URL로 이미지를 추가하는 경우, 다운로드하여 첨부할 필요는 없습니다`라고 적혀있어서
        // realm Memo와 Image Data의 관리를 위해 다운로드하여 관리하는 것으로 통일
        Alamofire.request(url).responseImage { response in
            if let image = response.result.value {
                vc.imageList.append(image)
                if let memo = vc.memoData {
                    guard let imageData = image.jpegData(compressionQuality: 0.3) else { vc.dismiss(animated: true, completion: nil)
                        return
                    }
                    self.appendImageToMemo(memo: memo, image: imageData)
                }
                vc.memoDetailImageCollectionView.reloadData()
            } else {
                vc.presentAlert(title: "올바르지 않은 URL", message: "해당 URL로부터 이미지를 가져올 수 없어요! 다른 URL로 시도해주시겠어요?")
            }
        }
    }
}
