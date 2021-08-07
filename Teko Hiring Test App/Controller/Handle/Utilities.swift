//
//  Utilities.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import Foundation

struct ProductInfomation: Codable {
    var id = 0
    var errorDescription = ""
    var name = ""
    var sku = ""
    var image = ""
    var color = 0
    
    
}

var ErrorProductList = [ProductInfomation]()
var ColorList = [String]()
