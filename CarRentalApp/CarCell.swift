//
//  CarCell.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 23.05.24.
//

import UIKit

class CarCell: UICollectionViewCell {
    
    @IBOutlet weak private var carTitleLabel: UILabel!
    @IBOutlet weak private var carSubtitleLabel: UILabel!
    @IBOutlet weak private var carPriceLabel: UILabel!
    @IBOutlet weak private var engineLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(title: String, subtitle: String, price: String, engine: String, image: String) {
        carTitleLabel.text = title
        carSubtitleLabel.text = subtitle
        carPriceLabel.text = price
        engineLabel.text = engine
        carImage.image = UIImage(named: image)
    }

}
