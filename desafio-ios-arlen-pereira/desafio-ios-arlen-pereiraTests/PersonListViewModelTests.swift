//
//  PersonListViewModelTests.swift
//  desafio-ios-arlen-pereiraTests
//
//  Created by Arlen Ricardo Pereira on 01/03/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import XCTest
@testable import desafio_ios_arlen_pereira

class PersonListViewModelTests: XCTestCase {

    var sut: PersonListViewModel!
    var mockDataService: MockDataService!
    
    override func setUp() {
        super.setUp()
        mockDataService = MockDataService()
        sut = PersonListViewModel(dataService: mockDataService)
    }

    override func tearDown() {
        sut = nil
        mockDataService = nil
        super.tearDown()
    }

    func test_requestFetchPersonList() {
        
        // Given
        let personListModel: PersonListModel? = nil
        mockDataService.completePersonList = personListModel
        
        // When
        sut.fetchPersonList()
        
        // Assert
        XCTAssert(mockDataService.isRequestFetchPersonsCalled)
        
    }

    func test_test_requestFetchPersonList_fail() {

        // Given
        let error = APIError.operationFail

        // When
        sut.fetchPersonList()
        mockDataService.requestFetchPersonsFail(error: error)

        // Assert
        XCTAssertEqual(sut.alertMessage!, error.localizedDescription)
    }
    
    func test_loading_whenFetching() {
        
        // Given
        var isLoading = false
        let except = XCTestExpectation(description: "Loading")
        sut.updateLoadingStatus = { [weak sut] in
            isLoading = sut!.isLoading
            except.fulfill()
        }
        
        // When
        sut.fetchPersonList()
        
        // Assert
        XCTAssertTrue(isLoading)
        
        mockDataService.requestFetchPersonSuccess()
        XCTAssertFalse(isLoading)
        
        wait(for: [except], timeout: 1.0)
    }
}

//MARK: - State Control
extension PersonListViewModelTests {
    private func goToRequestFetchPersonList() {
        mockDataService.completePersonList = StubPersonGenerator().stubPersonList()
        sut.fetchPersonList()
        mockDataService.requestFetchPersonSuccess()
    }
}

class MockDataService: DataServiceProtocol {
    
    var isRequestFetchPersonsCalled = false
    
    var completePersonList: PersonListModel? = nil
    
    var completeClosurePersons: ((Bool, PersonListModel?, APIError?) -> ())!
    
    func requestFetchPersons(offset: Int, completion: @escaping (Bool, PersonListModel?, APIError?) -> ()) {
        isRequestFetchPersonsCalled = true
        completeClosurePersons = completion
    }
    
    func requestFetchPersonHQ(personId: Int, offset: Int, completion: @escaping (Bool, PersonHQModel?, APIError?) -> ()) { }
    
    func requestFetchPersonSuccess() {
        completeClosurePersons(true, completePersonList, nil)
    }
    
    func requestFetchPersonsFail(error: APIError?) {
        completeClosurePersons(false, nil, error)
    }
}

class StubPersonGenerator {
    
    func stubPersonList() -> PersonListModel {
        let path = Bundle.main.path(forResource: "personList", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
//        decoder.dataDecodingStrategy = .base64
        let personList = try! decoder.decode(PersonListModel.self, from: data)
        return personList
    }
}
