//
//  MemoDetailVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/13.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class MemoDetailVC: BaseVC, MemoDetailVCProtocol {
    
    @IBOutlet weak var memoDetailTitleTextField: UITextField!
    @IBOutlet weak var memoDetailImageCollectionView: UICollectionView!
    @IBOutlet weak var memoDetailContentTextView: UITextView!
    
    weak var actor: MemoDetailActorDelegate?
    
    // Memo를 띄워주기 위해 MemoData 선언
    var memoData: Memo?
    var memoIndex: Int?
    // 이미지 인덱스를 저장하기 위한 imageIndex 선언
    var imageIndex: Int = 0 {
        didSet {
            if self.imageIndex >= 1 {
                guard let memo = self.memoData else { return }
                self.actor?.presentDeleteImageAlert(toVC: self, memo: memo, imageIndex: self.imageIndex)
            }
        }
    }
    // 이미지 변수를 임시 저장하기 위한 imageList 선언
    var imageList: [UIImage] = []
    // TextView Placeholder 색상을 지정해주기 위해 색상 설정
    var textViewPlaceholderColor: UIColor!
    
    /// 카메라 혹은 앨범을 위한 picker 선언
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memoDetailImageCollectionView.reloadData()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setDarkModeUI()
    }
    
    func initVC() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
        
        if let memo = self.memoData {
            for index in 0 ..< memo.imageList.count {
                self.imageList.append(UIImage(data: memo.imageList[index].imageUrl)!)
            }
        }
        
        self.imagePicker.delegate = self
        self.memoDetailContentTextView.delegate = self
        self.memoDetailImageCollectionView.delegate = self
        self.memoDetailImageCollectionView.dataSource = self
        
        self.setDarkModeUI()
        self.setMemoDetailUI()
    }
    
    func setDarkModeUI() {
        if self.isDarkMode {
            self.navigationController?.navigationBar.barTintColor = .black
            self.textViewPlaceholderColor = UIColor(hex: ColorPalette.darkModePlaceholderColor, alpha: 1.0)
        } else {
            self.navigationController?.navigationBar.barTintColor = .white
            self.textViewPlaceholderColor = UIColor(hex: ColorPalette.lightModePlaceholderColor, alpha: 1.0)
        }
    }
}
extension MemoDetailVC: MemoDetailVCRouterDelegate {
    
    static func makeMemoDetailVC() -> MemoDetailVC {
        let vc = MemoDetailVC()
        let actor = MemoDetailActor.shared
        
        vc.actor = actor
        actor.view = vc        
        return vc
    }
    
    func presentImagePickerController(targetVC vc: UIImagePickerController) {
        self.present(vc, animated: true, completion: nil)
    }
    
    func presentImageDetailVC(fromVC vc: MemoDetailVC, imageIndex: Int) {
        let imageDetailVCStoryboard = UIStoryboard(name: "ImageDetailVC", bundle: nil)
        guard let imageDetailVC = imageDetailVCStoryboard.instantiateViewController(withIdentifier: "ImageDetailVC") as? ImageDetailVC else { return }
        imageDetailVC.modalPresentationStyle = .fullScreen
        for image in self.imageList {
            imageDetailVC.imageList.append(image)
        }
        imageDetailVC.imageIndex = imageIndex
        self.present(imageDetailVC, animated: true, completion: nil)
    }
}
