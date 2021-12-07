//
//  StatusDataTableViewCell.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 1.12.21.
//

import UIKit
//TODO rename the view cell and use it from the account too
class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var imageViewIcon: UIImageView!
    
    @IBOutlet weak var iconHolderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backView.layer.cornerRadius = 8
        
        iconHolderView.layer.cornerRadius = 8
        iconHolderView.layer.shadowColor = UIColor.darkGray.cgColor
        iconHolderView.layer.shadowOffset = CGSize(width: 0, height: 0)
        iconHolderView.layer.shadowOpacity = 0.5
        iconHolderView.backgroundColor = UIColor.white
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
