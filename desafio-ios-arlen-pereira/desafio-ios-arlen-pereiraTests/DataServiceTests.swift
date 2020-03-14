//
//  DataServiceTests.swift
//  desafio-ios-arlen-pereiraTests
//
//  Created by Arlen Ricardo Pereira on 01/03/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import XCTest
@testable import desafio_ios_arlen_pereira

class DataServiceTests: XCTestCase {

    var sut: DataService?
    
    override func setUp() {
        super.setUp()
        sut = DataService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_requestFetchPersons() {
        
        // Given
        let sut = self.sut!
        let offset = 0
        
        // When
        let except = XCTestExpectation(description: "callback")
        
        sut.requestFetchPersons(offset: offset, completion: { (success, personList, error) in
            except.fulfill()
            XCTAssertEqual(personList?.data?.results?.count, 20)
            for person in (personList?.data?.results)! {
                XCTAssertNotNil(person.id)
            }
        })
        
        wait(for: [except], timeout: 3.1)
    }
    
    func test_requestFetchPersonHQ() {
        
        // Given
        let sut = self.sut!
        let offset = 0
        let personId = 1011175
        
        // When
        let except = XCTestExpectation(description: "callback")
        
        sut.requestFetchPersonHQ(personId: personId, offset: offset, completion: { (success, personHQ, error) in
            except.fulfill()
            XCTAssertEqual(personHQ?.data?.results?.count, 20)
            for personHQ in (personHQ?.data?.results)! {
                XCTAssertNotNil(personHQ.id)
            }
        })
        wait(for: [except], timeout: 3.1)
    }
}
