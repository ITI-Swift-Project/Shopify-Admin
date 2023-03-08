//
//  CustomerCollectionViewCell.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 05/03/2023.
//

import UIKit

class CustomerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var ordersLabel: UILabel!
    @IBOutlet weak var totalSpentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static func nib() -> UINib{
    return UINib(nibName: "CustomerCollectionViewCell", bundle: nil)
    }
}
