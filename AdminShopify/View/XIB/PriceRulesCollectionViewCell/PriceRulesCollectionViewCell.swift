//
//  PriceRulesCollectionViewCell.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 10/03/2023.
//

import UIKit

class PriceRulesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var priceRuleValueLabel: UILabel!
    @IBOutlet weak var priceRuleTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib{
    return UINib(nibName: "PriceRulesCollectionViewCell", bundle: nil)
    }
    
}
