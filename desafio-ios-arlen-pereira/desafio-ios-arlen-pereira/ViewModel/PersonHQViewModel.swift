//
//  PersonHQViewModel.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class PersonHQViewModel {

    //MARK: - Properties
    public var personHQs: [PersonHQResultModel]? {
        didSet {
            guard let personHQ = personHQs else { return }
            self.setupUI(with: personHQ)
            self.didFinishFetch?()
        }
    }
    
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
    var dataResult: BehaviorRelay<[PersonHQResultModel]> = BehaviorRelay(value: [])
    
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
    func fetchPersonHQ(personId: Int) {
        self.isLoading = true
        self.dataService.requestFetchPersonHQ(personId: personId, offset: offsetItem,completion: { [weak self] (success, personHQList, error) in
            self?.isLoading = false
            if success {
                var personHQListReorder: [PersonHQResultModel] = []
                var price = Double()
                
                if personHQList != nil {
                    for personHQ in (personHQList?.data?.results)! {
                        for priceHQ in personHQ.prices! {
                            let priceTemp = priceHQ.price!
                            if priceTemp > price {
                                price = priceTemp
                                personHQListReorder.append(personHQ)
                            }
                        }
                    }
                    self?.personHQs = personHQListReorder
                    price = 0
                }
            } else {
                self?.alertMessage = error?.localizedDescription
            }
        })
    }
    
    // MARK: - UI Logic
    private func setupUI(with personsHQ: [PersonHQResultModel]) {
        if !personsHQ.isEmpty {
            for personHQ in personsHQ {
                self.dataResult.accept(dataResult.value + [personHQ])
            }
        }
    }
}

