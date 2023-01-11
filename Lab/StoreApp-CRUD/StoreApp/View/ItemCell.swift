//
//  ItemCell.swift
//  StoreApp
//
//  Created by Macintosh on 03/11/2020.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
   
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var details: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(item: Item) {
        
        title.text = item.title
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage
        
    }
}
