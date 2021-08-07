//
//  ErrorProducts_TableViewCell.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit

class ErrorProductsTableViewCell: UITableViewCell {
    
    //IBOutlet
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var ErrorTextField: UITextField!
    @IBOutlet weak var SKUTextField: UITextField!
    @IBOutlet weak var ColorTextField: UITextField!
    @IBOutlet weak var EditButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
