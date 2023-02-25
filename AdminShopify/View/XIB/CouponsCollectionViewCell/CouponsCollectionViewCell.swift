//
//  CouponsCollectionViewCell.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 25/02/2023.
//

import UIKit

class CouponsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var discountCodeLabel: UILabel!
    @IBOutlet weak var discountImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func nib() -> UINib{
    return UINib(nibName: "CouponsCollectionViewCell", bundle: nil)
    }
}
