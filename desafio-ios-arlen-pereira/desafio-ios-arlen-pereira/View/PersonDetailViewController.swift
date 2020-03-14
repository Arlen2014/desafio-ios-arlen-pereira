//
//  PersonDetailViewController.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import SDWebImage
import JGProgressHUD

class PersonDetailViewController: UIViewController {

    // MARK: - Variables
    var displayed: PersonListResultModel?
    var movieIdFromList: Int?
    var segueId = "personHQSegue"
    var hud = JGProgressHUD(style: .extraLight)
    
    // MARK: - Interface
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var personDescriptionLabel: UILabel!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = displayed?.thumbnail?.path, let extensionString = displayed?.thumbnail?.extension {
            let imageString = "\(image).\(extensionString)"
            personImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            personImageView.sd_setImage(with: URL(string: imageString), placeholderImage: nil, options: [.continueInBackground, .refreshCached], completed: nil)
        }
        
        if let name = displayed?.name {
            personNameLabel.text = name
        }
        
        if let description = displayed?.description {
            personDescriptionLabel.text = description
        }
    }
    
    // MARK: - Function
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? PersonHQViewController {
            if let personId = displayed?.id {
                destinationViewController.personId = personId
            }
        }
    }
}
