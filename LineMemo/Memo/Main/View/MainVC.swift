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
    
    static let viewRouter: MainVCRouterDelegate = MainVC()
    
    weak var actor: MainActorDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initVC()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
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
    func makeMainVC() -> MainVC {
        let vc = MainVC()
        let actor = MainActor.shared
        
        vc.actor = actor
        actor.view = vc
        return vc
    }
    
    func presentMemoDetailVC() {
        let memoDetailVC = MemoDetailVC.viewRouter.makeMemoDetailVC()
        self.navigationController?.pushViewController(memoDetailVC, animated: true)
    }
}
