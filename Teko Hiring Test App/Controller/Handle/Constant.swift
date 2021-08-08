//
//  Constant.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import Foundation

struct Storyboard {

    static var ErrorProducts_StoryboardID = "ErrorProductsViewController"
    static var EditProductInfo_StoryboardID = "EditProductInfoViewController"

}

struct TableViewCell {
    
    static var ErrorProduct_TableViewCell = "ErrorProductTableViewCell"
    
}

//Duong dan API danh sach san pham loi
let ErrorProducts_URLString = "https://hiring-test.stag.tekoapis.net/api/products"

//Duong dan API danh sach mau
let Color_URLString = "https://hiring-test.stag.tekoapis.net/api/colors"

//So san pham nhieu nhat hien thi trong mot trang
let MaxProductNumberPerPage = 10
