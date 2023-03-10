//
//  PriceRulesTableViewCell.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 10/03/2023.
//

import UIKit

class PriceRulesTableViewCell: UITableViewCell {

    @IBOutlet weak var priceRuleValueLabel: UILabel!
    @IBOutlet weak var priceRuleTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib{
    return UINib(nibName: "PriceRulesTableViewCell", bundle: nil)
    }
}
