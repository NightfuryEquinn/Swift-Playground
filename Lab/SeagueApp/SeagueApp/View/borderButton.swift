//
//  borderButton.swift
//  SeagueApp
//
//  Created by YIP ZI XIAN on 08/12/2022.
//

import UIKit

class borderButton: UIButton {
    // Override button style
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.white.cgColor
    }
}
