//
//  PersonListViewModel.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PersonListViewModel {
    
    //MARK: - Properties
    public var persons: PersonListModel? {
        didSet {
            guard let person = persons else { return }
            self.setupUI(with: person)
            self.didFinishFetch?()
        }
    }
    
    var personsTemp: [PersonListResultModel] = []
    
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var offsetItem = 0
    var dataResult: BehaviorRelay<[PersonListResultModel]> = BehaviorRelay(value: [])
    
    let dataService: DataServiceProtocol
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchPersonList() {
        self.isLoading = true
        self.dataService.requestFetchPersons(offset: offsetItem, completion: { [weak self] (success, personList, error) in
            self?.isLoading = false
            if success {
                self?.persons = personList
            } else {
                self?.alertMessage = error?.localizedDescription
            }
        })
    }
    
    // MARK: - UI Logic
    private func setupUI(with persons: PersonListModel) {
        if persons.data != nil {
            for item in ((persons.data?.results)!) {
                self.dataResult.accept(dataResult.value + [item])
            }
        }
    }
}
