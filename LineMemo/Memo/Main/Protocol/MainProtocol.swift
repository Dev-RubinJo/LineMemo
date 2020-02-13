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
    
    func makeMainVC() -> MainVC
    
    func presentMemoDetailVC()
}

protocol MainActorDelegate: class {
    
    var view: MainVCRouterDelegate? { get set }
    
    func didLoadMainVC()
    
    func didTapAddButton()
}
