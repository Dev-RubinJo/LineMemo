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
    // TextView Placeholder 색상을 지정해주기 위해 색상 설정
    var textViewPlaceholderColor: UIColor!
   
    /// 카메라 혹은 앨범을 위한 picker 선언
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setDarkModeUI()
    }
    
    func initVC() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = .white
        
        self.memoDetailTitleTextField.delegate = self
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
extension MemoDetailVC: MemoDetailVCRouterProtocol {
    
    static func makeMemoDetailVC() -> MemoDetailVC {
        let vc = MemoDetailVC()
        let actor = MemoDetailActor.shared
        
        vc.actor = actor
        actor.view = vc        
        return vc
    }
}
