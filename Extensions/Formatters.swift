//
//  Formatters.swift
//  CryptoMarketApp
//
//  Created by GoStartups Service on 6.12.21.
//

import Foundation
import UIKit

extension UILabel{
    func setFormatedNumber(num: Int?){
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.numberStyle = .decimal
        self.text = numberFormatter.string(from: NSNumber(value: num ?? 0))
    }

}
