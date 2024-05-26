//
//  MainCell.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 22.05.24.
//

import UIKit

class MainCell: UICollectionViewCell {

    @IBOutlet weak private var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak private var categoryCountLabel: UILabel!
    @IBOutlet weak private var categoryBgView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure (image: String, count: String, title: String, backgroundColor: UIColor) {
        categoryCountLabel.text = count
        categoryImage.image = UIImage(named: image)
        categoryTitleLabel.text = title
        categoryBgView.backgroundColor = backgroundColor
        
        
        let titleColor: UIColor = backgroundColor == .white ? .black : .white
        categoryTitleLabel.textColor = titleColor
        
        let countColor: UIColor = backgroundColor == .white ? .gray : .white
        categoryCountLabel.textColor = countColor
    }

}
