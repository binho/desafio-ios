//
//  JavaPopTests.swift
//  JavaPopTests
//
//  Created by Cleber Santos on 12/29/16.
//  Copyright © 2016 Cleber Santos. All rights reserved.
//

import XCTest
@testable import JavaPop

class JavaPopTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testRepoViewModelWithRxJava() {
        let rxJava = Repo(name: "RxJava", description: "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.", forks: 3540, stars: 20097)
        let rxJavaViewModel = RepoViewModel(repo: rxJava)
        
        XCTAssertEqual(rxJavaViewModel.nameText, "RxJava")
        XCTAssertEqual(rxJavaViewModel.descriptionText, "RxJava – Reactive Extensions for the JVM – a library for composing asynchronous and event-based programs using observable sequences for the Java VM.")
        XCTAssertEqual(rxJavaViewModel.infoString, "3540 - 20097")
    }
    
    func testPullViewModelWithOpen() {
        let model = Pull(title: "2.x: don't call the Thread's uncaught handler from RxJavaPlugins.onError", description: "This PR removes the call to the current thread's uncaught exception handler if there is no `RxJavaPlugins.onError` handler setup. The default behavior of the `UncaughtExceptionHandler` on Android crashes the whole app. Unit tests that expected this call are modified/disabled.", state: .open)
        let viewModel = PullViewModel(pull: model)
        
        XCTAssertEqual(viewModel.titleText, "2.x: don't call the Thread's uncaught handler from RxJavaPlugins.onError")
        XCTAssertEqual(viewModel.descriptionText, "This PR removes the call to the current thread's uncaught exception handler if there is no `RxJavaPlugins.onError` handler setup. The default behavior of the `UncaughtExceptionHandler` on Android crashes the whole app. Unit tests that expected this call are modified/disabled.")
        XCTAssertEqual(viewModel.state, State.open)
    }
    
}
