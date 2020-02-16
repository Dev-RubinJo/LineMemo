//
//  MainVC.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import UIKit

class MainVC: BaseVC, MainVCDelegate {
    
    @IBOutlet weak var mainVCTitleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var memoListTableView: UITableView!
    
    weak var actor: MainActorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.memoListTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setDarkModeUI()
    }
    
    func initVC() {
        self.memoListTableView.delegate = self
        self.memoListTableView.dataSource = self
        
        self.setMainUI()
        self.setDarkModeUI()
        self.actor?.didLoadMainVC()
    }
    
    func setDarkModeUI() {
        if self.isDarkMode {
            self.mainVCTitleLabel.textColor = .white
        } else {
            self.mainVCTitleLabel.textColor = .black
        }
    }
}
extension MainVC: MainVCRouterDelegate {
    
    static func makeMainVC() -> MainVC {
        let vc = MainVC()
        let actor = MainActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
    
    func presentMemoDetailVCToAdd() {
        let memoDetailVC = MemoDetailVC.makeMemoDetailVC()
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
    
    func presentMemoDetailVCToEdit(targetMemo memo: Memo) {
        let memoDetailVC = MemoDetailVC.makeMemoDetailVC()
        memoDetailVC.memoData = memo
        
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
}
