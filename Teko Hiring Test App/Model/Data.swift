//
//  Data.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/8/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import Foundation

//
// MARK: - Class Data
//
class Data {
    //
    // MARK: - Class Methods
    //
    static func loadData(completionHandler: @escaping () -> Void) {
        
        //Doc du lieu danh sach san pham loi tu API cho truoc
        ReadProductData {
            
            completionHandler()
            
        }
        
        //Doc du lieu danh sach mau tu API cho truoc
        ReadColorData {
            
            completionHandler()
            
        }

    }
    
    static func ReadProductData(completionHandler: @escaping () -> Void) {
        
        ReadDataFromURL(URLString: ErrorProducts_URLString) { (dict) in
            
            //Doc cac san pham loi
            for product in dict! {
                
                var color = 0
                if let colorNumber = product["color"] as? Int {
                    color = colorNumber
                }
                var info = ProductInfomation()
                info.name = "\(product["name"]!)"
                info.id = product["id"] as! Int
                info.errorDescription = "\(product["errorDescription"]!)"
                info.name = "\(product["name"]!)"
                info.sku = "\(product["sku"]!)"
                info.image = "\(product["image"]!)"
                info.color = color
                ErrorProductList.append(info)
                ValidArray.append(true)
                
                completionHandler()
            }
            
        }
        
    }
    
    static func ReadColorData(completionHandler: @escaping () -> Void) {
        
        ReadDataFromURL(URLString: Color_URLString) { (dict) in
            
            var info = ColorInfomation()
            
            //Khoi tao doi voi truong hop san pham khong co du lieu mau
            info.id = 0
            info.name = "No color data"
            ColorList.append(info)
            
            //Doc cac mau
            for product in dict! {
                
                info.id = product["id"] as! Int
                info.name = "\(product["name"]!)"
                ColorList.append(info)
                
            }
            
            completionHandler()
            
        }
        
    }
    
    static func ReadDataFromURL(URLString: String, completion: @escaping ([[String:Any]]?) -> ()) {
        
        guard let requestUrl = URL(string:URLString) else { return }
        var request = URLRequest(url:requestUrl)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if error == nil, let usableData = data {
                
                let data = try? JSONSerialization.jsonObject(with: usableData, options:[])
                //Dictionary cua danh sach doc duoc tu API
                let dict = data as? [[String:Any]]
                
                //Tra ve ket qua
                completion(dict)
                
            }
        }
        task.resume()
        
    }
    
}
