//
//  PersonHQViewController.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import JGProgressHUD

class PersonHQViewController: UIViewController {

    // MARK: - Injection
    var viewModel: PersonHQViewModel?
    

    // MARK: - Variables
    var personId: Int?
    var resultHQ: PersonHQResultModel?
    var movieIdFromList: Int?
    let disposeBag = DisposeBag()
    var hud = JGProgressHUD(style: .extraLight)
    
    // MARK: - Interface
    @IBOutlet weak var hqFrame: UIView!
    @IBOutlet weak var hqImageView: UIImageView!
    @IBOutlet weak var hqTitleLabel: UILabel!
    @IBOutlet weak var hqDescriptionLabel: UILabel!
    @IBOutlet weak var hqPriceLabel: UILabel!
    @IBOutlet weak var hqNoFoundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hqNoFoundLabel.isHidden = true
        viewModel = PersonHQViewModel(dataService: DataService())
        
        attemtFetchHQList()
    }
    
    // MARK: - Function
    private func attemtFetchHQList() {
        
        viewModel?.updateLoadingStatus = { [weak self] () in
            let isLoading = self?.viewModel?.isLoading ?? false
            if isLoading {
                self?.activityIndicatorStart()
            } else {
                self?.activityIndicatorStop()
            }
        }
        
        viewModel?.showAlertClosure = { [weak self] () in
            if (self?.viewModel?.error.debugDescription) != nil {
            }
        }
        
        viewModel?.didFinishFetch = { [weak self] () in
            self?.viewModel?.dataResult.asObservable().subscribe(onNext: { personHQ in
                
                if !personHQ.isEmpty {
                    self?.hqFrame.isHidden = false
                    self?.hqNoFoundLabel.isHidden = true
                    if let image = personHQ[0].thumbnail?.path, let extensionString = personHQ[0].thumbnail?.extension {
                        let imageString = "\(image).\(extensionString)"
                        self?.hqImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                        self?.hqImageView.sd_setImage(with: URL(string: imageString), placeholderImage: nil, options: [.continueInBackground, .refreshCached], completed: nil)
                    }
                    
                    if let title = personHQ[0].title {
                        self?.hqTitleLabel.text = title
                    }
                    
                    if let description = personHQ[0].description {
                        self?.hqDescriptionLabel.text = description
                    }
                    
                    if let prices = personHQ[0].prices {
                        for price in prices {
                            self?.hqPriceLabel.text = "R$ \(String(format:"%.2f", price.price!))"
                        }
                    }
                } else {
                    self?.hqFrame.isHidden = true
                    self?.hqNoFoundLabel.isHidden = false
                }
            }).disposed(by: self!.disposeBag)
        }
        
        self.viewModel?.fetchPersonHQ(personId: personId!)
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
}
