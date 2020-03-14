//
//  PersonListCollectionViewCell.swift
//  desafio-ios-arlen-pereira
//
//  Created by Arlen Ricardo Pereira on 29/02/20.
//  Copyright © 2020 Arlen Ricardo Pereira. All rights reserved.
//

import UIKit
import SDWebImage

class PersonListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Interface
    @IBOutlet weak var personImageView: UIImageView!
    @IBOutlet weak var personNameLabel: UILabel!
    private var gradient = CAGradientLayer()
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Variables
    var personListCell: PersonListResultModel?
    {
        didSet {
            if let image = personListCell?.thumbnail?.path, let extensionString = personListCell?.thumbnail?.extension {
                let imageString = "\(image).\(extensionString)"
                personImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
                personImageView.sd_setImage(with: URL(string: imageString), placeholderImage: nil, options: [.continueInBackground, .refreshCached], completed: nil)
            }
            
            if let name = personListCell?.name {
                personNameLabel.text = name
            }
            
        }
    }
}
