//
//  EditProductInfo_ViewController.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/8/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit
import SDWebImageWebPCoder

class EditProductInfo_ViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var SKUTextField: UITextField!
    @IBOutlet weak var ProductImageView: UIImageView!
    
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    
    @IBOutlet weak var ColorPickerView: UIPickerView!
    
    var info = ProductInfomation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Init()
    }
    
    @IBAction func act_Cancel(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func act_Save(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func Init() {
        
        //Khoi tao giao dien
        UIInit()
        
        //Khoi tao du lieu
        DataInit()
        
    }
    
    func UIInit() {
        
        //Bo tron goc cho cac nut
        CancelButton.layer.cornerRadius = CancelButton.frame.height / 2
        SaveButton.layer.cornerRadius = SaveButton.frame.height / 2
        
        //Do day duong vien
        CancelButton.layer.borderWidth = 1
        CancelButton.layer.borderColor = UIColor.systemGreen.cgColor
        
    }
    
    func DataInit() {
        
        IDLabel.text = String(info.id)
        ErrorLabel.text = info.errorDescription
        NameTextField.text = info.name
        SKUTextField.text = info.sku
        
        let imagePath = info.image
        if (imagePath != "") {
            
            let url = URL(string: imagePath)!
            let webPCoder = SDImageWebPCoder.shared
            SDImageCodersManager.shared.addCoder(webPCoder)
            DispatchQueue.main.async {
                
                self.ProductImageView.sd_setImage(with: url)
                
            }
            
        }
        
        //Mau cua san pham
        if (info.color > 0) {
         
            ColorPickerView.selectRow(info.color, inComponent: 0, animated: true)
            
        }
    }
    
}

extension EditProductInfo_ViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ColorList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(ColorList[row].name)
    }
}
