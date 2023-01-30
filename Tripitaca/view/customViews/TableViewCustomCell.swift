//
//  TableViewCustomCell.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 26/01/2023.
//

import UIKit

class TableViewCustomCell: UITableViewCell {

    @IBOutlet weak var featureImage: UIImageView!
    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyLocation: UILabel!
    @IBOutlet weak var propertyRating: UILabel!
    @IBOutlet weak var propertyPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        featureImage.layer.cornerRadius = 10
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCells(with model : PropertyDataClass){

        featureImage.image = UIImage(named: model.featuredImage!)
        propertyName.text = model.name
        propertyLocation.text = model.location
        propertyRating.text = model.rating
        propertyPrice.text = model.price
    }

}
