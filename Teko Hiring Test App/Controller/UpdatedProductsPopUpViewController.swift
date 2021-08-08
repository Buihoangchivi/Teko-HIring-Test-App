//
//  UpdatedProductsPopUpViewController.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/8/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit
import SDWebImageWebPCoder

//
// MARK: - Updated Products Popup View Controller
//
class UpdatedProductsPopUpViewController: UIViewController {

    //
    // MARK: - Outlets
    //
    @IBOutlet weak var OKButton: UIButton!
    @IBOutlet weak var ErrorProductsTableView: UITableView!
    @IBOutlet weak var PopUpView: UIView!
    
    //
    // MARK: - View Controller
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        Init()
    }
    
    @IBAction func act_PopUpBackgroundButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func Init() {
        
        //Khoi tao giao dien
        UIInit()
        
    }
    
    func UIInit() {
        
        //Bo tron goc cho cac nut va view
        OKButton.layer.cornerRadius = OKButton.frame.height / 2
        PopUpView.layer.cornerRadius = 10
        
        //Lam mo nen cua view
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.bringSubviewToFront(view.subviews[view.subviews.count - 2])
        
    }

}

//
// MARK: - Table View Data Source and Table View Delegate
//
extension UpdatedProductsPopUpViewController:UITableViewDelegate,UITableViewDataSource{
    //Tra ve so hang cua bang trong 1 trang
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ErrorProductList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.ErrorProduct_TableViewCell) as! ErrorProductsTableViewCell
        
        let index = indexPath.row
        
        //Nap du lieu vao man hinh chinh sua
        cell.NameLabel.text = ErrorProductList[index].name
        cell.ErrorLabel.text = ErrorProductList[index].errorDescription
        cell.SKULabel.text = ErrorProductList[index].sku
        let colorID = ErrorProductList[index].color
        if (colorID >= 0 && colorID < ColorList.count) {
            
            cell.ColorLabel.text = ColorList[colorID].name
            
        }
        
        let imagePath = ErrorProductList[index].image
        if (imagePath != "") {
            
            let url = URL(string: imagePath)!
            let webPCoder = SDImageWebPCoder.shared
            SDImageCodersManager.shared.addCoder(webPCoder)
            DispatchQueue.main.async {
                
                cell.ProductImageView.sd_setImage(with: url)
                
            }
            
        }

        return cell
        
    }
    
    //Chi dinh do cao cho 1 o
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        ErrorProductsTableView.deselectRow(at: indexPath, animated: true)
    
    }
}
