//
//  IBAssignmntTests.swift
//  IBAssignmntTests
//
//  Created by Ichrak BORGI on 1/10/2021.
//

import XCTest
@testable import IBAssignmnt

class IBAssignmntTests: XCTestCase {
    var mainViewController: IBMainViewController!
    var popView: UIView!
    
    func makeSUT() -> IBMainViewController {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let sut = storyboard.instantiateViewController(identifier: "IBMainViewController") as! IBMainViewController
            sut.loadViewIfNeeded()
         return sut
     }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
     
          
        let sut = makeSUT()
            
         sut.viewDidLoad()
            
        XCTAssertTrue((sut.poppupView != nil))
   
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mainViewController = nil
    }

    func testTextFormat() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut = makeSUT()
        sut.viewDidLoad()
        XCTAssertNotEqual(sut.textfield.text,"zzzzfsd")
        
    }
    
    func testEncryptedData() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let sut = makeSUT()
        sut.viewDidLoad()
        XCTAssertTrue(((sut.textfield.text?.toBase64()) != nil))
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
