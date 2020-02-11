//
//  SplashTests.swift
//  LineMemoTests
//
//  Created by YooBin Jo on 2020/02/11.
//  Copyright © 2020 YooBin Jo. All rights reserved.
//

import XCTest
@testable import LineMemo

class SplashTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMakeSplashVC() {
        let vc = SplashVC.viewRouter.makeSplashVC()
        
        XCTAssertNotNil(vc)
    }
    
    func testSplashVCActorIsNil() {
        let vc = SplashVC.viewRouter.makeSplashVC()
        
        XCTAssertNotNil(vc.actor!)
    }
    func testSplashVCActorViewIsNil() {
        let vc = SplashVC.viewRouter.makeSplashVC()
        
        XCTAssertNotNil(vc.actor?.view!)
    }
    
    func testSplashVCPresentMain() {
        let vc = SplashVC.viewRouter.makeSplashVC()
        let content: String = vc.presentMainVC()
        XCTAssertEqual(content, "Go to Main")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
