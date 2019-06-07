//
//  CoordinatorTests.swift
//  babylonTestTests
//
//  Created by Amish Patel on 07/06/2019.
//  Copyright © 2019 Amish Patel. All rights reserved.
//

import XCTest
@testable import babylonTest

class CoordinatorTests: XCTestCase {
    
    private var mainCoordinator: CoordinatorStub?
    
    override func setUp() {
        mainCoordinator = CoordinatorStub()
    }
    
    override func tearDown() {
         mainCoordinator = nil
    }
    
    func test_addChildCoordinator() {
        
        let coordinatorA = makeSUT()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        
        let coordinatorToTest = mainCoordinator?.childCoordinators[0]
        
        XCTAssert(coordinatorToTest === coordinatorA)
    }
    
    func test_removeChildCoordinator() {
        let coordinatorA = makeSUT()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorA)
        
        XCTAssertEqual(0, mainCoordinator?.childCoordinators.count)
    }
    
    func test_addChildCoordinator_onlyAddsOneInstance() {
        let coordinatorA = makeSUT()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        
        XCTAssertEqual(1, mainCoordinator?.childCoordinators.count)
    }
    
    func test_removeChildCoordinator_fromMiddle() {
        let coordinatorA = makeSUT()
        let coordinatorB = makeSUT()
        let coordinatorC = makeSUT()
        let coordinatorD = makeSUT()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorB)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorC)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorD)
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorC)
        
        XCTAssertEqual(3, mainCoordinator?.childCoordinators.count)
    }
    
    func test_removeChildCoordinator_removeSameChildTwice() {
        let coordinatorA = makeSUT()
        let coordinatorB = makeSUT()
        let coordinatorC = makeSUT()
        
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorA)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorB)
        mainCoordinator?.addChildCoordinator(coordinator: coordinatorC)
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorC)
        mainCoordinator?.removeChildCoordinator(coordinator: coordinatorC)
        
        XCTAssertEqual(2, mainCoordinator?.childCoordinators.count)
    }
    
    private func makeSUT() -> CoordinatorStub {
        return CoordinatorStub()
    }
}


private class CoordinatorStub: Coordinator {
    var childCoordinators: [Coordinator] = [Coordinator]()
    
    func start() {
        
    }
}
