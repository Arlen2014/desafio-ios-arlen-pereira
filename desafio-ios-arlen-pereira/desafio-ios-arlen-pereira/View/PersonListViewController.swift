//
//  PersonListViewController.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD
import MMBannerLayout

class PersonListViewController: UIViewController {
    
    // MARK: - Injection
    var viewModel: PersonListViewModel?
    
    // MARK: - Variables
    var cellId = "personsCell"
    var segueId = "personDetailSegue"
    var displayed: BehaviorRelay<[PersonListResultModel]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    var hud = JGProgressHUD(style: .extraLight)
    
    // MARK: - Interface
    @IBOutlet weak var collectionViewFrame: UICollectionView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = PersonListViewModel(dataService: DataService())
        
        if let layout = collectionViewFrame.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let size = CGSize(width: (collectionViewFrame.bounds.width-30)/2, height: 200)
            layout.itemSize = size
        }
        attemtFetchPersonList()
    }
    
    // MARK: - Function
    private func attemtFetchPersonList() {
        
        viewModel?.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel?.isLoading ?? false
                if isLoading {
                    self?.activityIndicatorStart()
                } else {
                    self?.activityIndicatorStop()
                }
            }
        }
        
        viewModel?.showAlertClosure = { [weak self] () in
            if let error = self?.viewModel?.error {
                print(error.localizedDescription)
            }
        }
        
        self.viewModel?.didFinishFetch = { [weak self] () in
            self?.viewModel?.dataResult.asObservable().bind(to: self!.collectionViewFrame.rx.items(cellIdentifier: self!.cellId, cellType: PersonListCollectionViewCell.self)) { index, item, cell in
                cell.personListCell = item
                
            }.disposed(by: self!.disposeBag)
            
            self?.collectionViewFrame.reloadData()
        }
        
        self.viewModel?.fetchPersonList()
    }
    
    // MARK: - UI Setup
    private func activityIndicatorStart() {
        hud.vibrancyEnabled = true
        hud.textLabel.text = "Loading"
        hud.layoutMargins = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 10.0, right: 0.0)
        hud.show(in: self.view, animated: true)
    }
    
    private func activityIndicatorStop() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 0.1, animations: {
                self.hud.textLabel.text = "Success"
                self.hud.detailTextLabel.text = nil
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            })
            
            self.hud.dismiss(afterDelay: 0.2)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueId {
            if let destinationViewController = segue.destination as? PersonDetailViewController {
                if let person = sender as? PersonListCollectionViewCell {
                    destinationViewController.displayed = person.personListCell
                }
            }
        }
    }
}
