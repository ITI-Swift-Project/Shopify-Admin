//
//  CouponsTableViewCell.swift
//  AdminShopify
//
//  Created by Ahmad Ayman Mansour on 10/03/2023.
//

import UIKit

class CouponsTableViewCell: UITableViewCell {

    @IBOutlet weak var couponCodeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
           }

        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func nib() -> UINib{
    return UINib(nibName: "CouponsTableViewCell", bundle: nil)
    }
}
