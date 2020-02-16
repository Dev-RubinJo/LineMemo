//
//  MainProtocol.swift
//  LineMemo
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

protocol MainVCDelegate: BaseVCProtocol {
    
    var actor: MainActorDelegate? { get set }
}

protocol MainVCRouterDelegate: class {
    
    static func makeMainVC() -> MainVC
    
    func presentMemoDetailVCToAdd()
    
    func presentMemoDetailVCToEdit(targetMemo memo: Memo, index: Int)
}

protocol MainActorDelegate: class {
    
    var view: MainVCRouterDelegate? { get set }
    
    var memoListData: [Memo] { get }
    
    func didLoadMainVC()
    
    func didTapAddButton()
    
    func didTapMemoListTableViewCell(index: Int)
    
    func deleteMemoData(_ memo: Memo, _ index: Int)
}
