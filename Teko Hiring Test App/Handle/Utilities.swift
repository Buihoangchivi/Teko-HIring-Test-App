//
//  Utilities.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import Foundation
import UIKit

struct ProductInfomation {
    
    var id = 0
    var errorDescription = ""
    var name = ""
    var sku = ""
    var image = ""
    var color = 0
    
}

struct ColorInfomation {
    
    var id = 0
    var name = ""
    
}

var ErrorProductList = [ProductInfomation]()
var ColorList = [ColorInfomation]()
var ValidArray = [Bool]()

//Kiem tra ten san pham co hop le hay khong
func CheckValidation_NameProduct(nameLabel: UILabel, errorLabel: UILabel) -> Bool {
    
    var result = false
    let name = nameLabel.text!
    if (name.count == 0) {
        
        errorLabel.text = "Product Name is required!"
        errorLabel.textColor = UIColor.systemRed
        
    }
    else if (name.count > 50) {
        
        errorLabel.text = "Max length is 50 characters!"
        errorLabel.textColor = UIColor.systemRed
        
    }
    else {
        
        errorLabel.text = "Product Name is valid!"
        errorLabel.textColor = UIColor.systemGreen
        result = true
        
    }
    return result
    
}

//Kiem tra SKU co hop le hay khong
func CheckValidation_SKU(nameLabel: UILabel, errorLabel: UILabel) -> Bool {
    
    var result = false
    let name = nameLabel.text!
    if (name.count == 0) {
        
        errorLabel.text = "SKU is required!"
        errorLabel.textColor = UIColor.systemRed
        
    }
    else if (name.count > 20) {
        
        errorLabel.text = "Max length is 20 characters!"
        errorLabel.textColor = UIColor.systemRed
        
    }
    else {
        
        errorLabel.text = "SKU is valid!"
        errorLabel.textColor = UIColor.systemGreen
        result = true
        
    }
    return result
    
}
