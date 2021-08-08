//
//  ErrorProducts_ViewController.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit
import SDWebImageWebPCoder

//
// MARK: - Error Products View Controller
//
class ErrorProductsViewController: UIViewController {
    
    //
    // MARK: - Outlets
    //
    @IBOutlet weak var ErrorProductsTableView: UITableView!
    @IBOutlet weak var FirstPageButton: UIButton!
    @IBOutlet weak var PrevPageButton: UIButton!
    @IBOutlet weak var CurrentPageLabel: UILabel!
    @IBOutlet weak var ChangeCurrentPageButton: UIButton!
    @IBOutlet weak var NextPageButton: UIButton!
    @IBOutlet weak var LastPageButton: UIButton!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var TableViewLeftConstraint: NSLayoutConstraint!
    
    //
    // MARK: - Variables And Properties
    //
    //Tong so trang va trang dang hien thi
    var CurrentPage = 1
    var TotalPage = 0
    
    //Index cua san pham duoc chon de chinh sua
    var SelectedProductIndex = 0
    
    //
    // MARK: - View Controller
    //
    override func viewWillAppear(_ animated: Bool) {
        TableViewLeftConstraint.constant += view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        TableViewLeftConstraint.constant -= view.bounds.width
        UIView.animate(withDuration: 0.9,
                       delay: 1,
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Init()
        
    }
    
    @IBAction func act_ClickPageButton(_ sender: Any) {
        
        let button = (sender as! UIButton).restorationIdentifier!
        var temp = view.bounds.width
        //temp < 0 thi animation tu phai sang trai
        //temp > 0 thi animation tu trai sang phai
        if (button == "PrevPage" || button == "FirstPage") {
            temp *= -1
        }
        
        //Neu nhan nut Next hoac Last Page
        if (temp > 0) {
            if (button == "NextPage") {
                CurrentPage += 1 //Tang so trang len 1
            }
            else {
                CurrentPage = TotalPage //Trang cuoi cung
            }
            
            //Neu dang o trang cuoi cung thi vo hieu hoa 2 nut Next va Last Page
            if (CurrentPage == TotalPage) {
                ChangButtonState(NextPageButton, false)
                ChangButtonState(LastPageButton, false)
            }
            //Active 2 nut Prev va First Page
            if (PrevPageButton.isEnabled == false) {
                ChangButtonState(PrevPageButton, true)
                ChangButtonState(FirstPageButton, true)
            }
        }
        else { //Neu nhan nut Prev hoac First Page
            if (button == "PrevPage") {
                self.CurrentPage -= 1 //Giam so trang xuong 1
            }
            else {
                self.CurrentPage = 1 //Trang dau tien
            }
            
            //Neu dang o trang dau tien thi vo hieu hoa 2 nut Prev va First Page
            if (CurrentPage == 1) {
                ChangButtonState(PrevPageButton, false)
                ChangButtonState(FirstPageButton, false)
            }
            //Active 2 nut Next va Last Page
            if (NextPageButton.isEnabled == false) {
                ChangButtonState(NextPageButton, true)
                ChangButtonState(LastPageButton, true)
            }
        }
        
        //Cap nhat so trang tren giao dien
        CurrentPageLabel.text = "\(CurrentPage) / \(TotalPage)"
        
        //Scroll len tren
        ErrorProductsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        
        //Reload lai bang
        ErrorProductsTableView.reloadData()
        
    }
    
    @IBAction func act_SubmitData(_ sender: Any) {
        
        for element in ValidArray {
            
            if (element == false) {
                
                //Thong bao khong hop le
                let alertWrongNumber = UIAlertController(title: "Invalid Product Infomation", message: "Product Name is required, max length 50 characters and SKU is required, max length 20 characters.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
                alertWrongNumber.addAction(okAction)
                self.present(alertWrongNumber, animated: true, completion: nil)
                return
                
            }
            
        }
        
        let dest = self.storyboard?.instantiateViewController(identifier: Storyboard.UpdatedProductInfo_StoryboardID) as! UpdatedProductsPopUpViewController
        dest.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dest.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        self.present(dest, animated: true, completion: nil)
        
    }
    
    func Init() {
        
        //Khoi tao giao dien
        UIInit()
        
        //Khoi tao du lieu
        Data.loadData { () in
            
            self.CurrentPage = 1
            self.TotalPage = 0
                
            DispatchQueue.main.async {
                
                //Phan trang
                self.UpdatePageNumber()
                
                //Reload lai bang
                self.ErrorProductsTableView.reloadData()
                
            }
            
        }
        
    }
    
    func UIInit() {
        
        //Bo goc cho nut thay doi so trang hien tai
        ChangeCurrentPageButton.layer.borderWidth = 0.2
        ChangeCurrentPageButton.layer.cornerRadius = 10
        
        //Bo tron goc cho cac nut phan trang
        FirstPageButton.layer.cornerRadius = FirstPageButton.frame.height / 2
        PrevPageButton.layer.cornerRadius = PrevPageButton.frame.height / 2
        NextPageButton.layer.cornerRadius = NextPageButton.frame.height / 2
        LastPageButton.layer.cornerRadius = LastPageButton.frame.height / 2
        //Bo tron goc cho nut gui du lieu
        SubmitButton.layer.cornerRadius = SubmitButton.frame.height / 2
        
    }
    
    /*func DataInit() {
        
        //Doc du lieu danh sach san pham loi tu API cho truoc
        ReadProductData()
        
        //Doc du lieu danh sach mau tu API cho truoc
        ReadColorData()
        
    }
    
    func ReadProductData() {
        
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
                self.ValidArray.append(true)
                
            }
            
            DispatchQueue.main.async {
                
                //Phan trang
                self.UpdatePageNumber()
                
                //Reload lai bang
                self.ErrorProductsTableView.reloadData()
                
            }
            
        }
        
    }
    
    func ReadColorData() {
        
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
            
            //Reload lai bang
            DispatchQueue.main.async {
                self.ErrorProductsTableView.reloadData()
            }
            
        }
        
    }
    
    func ReadDataFromURL(URLString: String, completion: @escaping ([[String:Any]]?) -> ()) {
        
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
        
    }*/
    
    func UpdatePageNumber() {
        
        if (ErrorProductList.count == 0) {
            
            TotalPage = 0
            CurrentPage = 0
            
        }
        else {
            
            TotalPage = (ErrorProductList.count - 1) / MaxProductNumberPerPage + 1
            if (CurrentPage > TotalPage || CurrentPage == 0) {
                
                CurrentPage = 1
                
            }
        }
        
        //Cap nhat trang thai cua cac nut phan trang
        if (TotalPage < 2) { //Truong hop nhieu nhat 1 trang nen khong di chuyen trang duoc
            
            if (NextPageButton.isEnabled == true) {
                ChangButtonState(NextPageButton, false)
                ChangButtonState(LastPageButton, false)
            }
            
            if (PrevPageButton.isEnabled == true) {
                ChangButtonState(PrevPageButton, false)
                ChangButtonState(FirstPageButton, false)
            }
            
        }
        else { //Truong hop it nhat 2 trang
            
            if (CurrentPage == 1) { //O trang dau tien
                
                //Co the tien toi trang sau
                ChangButtonState(NextPageButton, true)
                ChangButtonState(LastPageButton, true)
                
                //Khong the quay ve trang truoc
                ChangButtonState(PrevPageButton, false)
                ChangButtonState(FirstPageButton, false)
                
            }
            else if (CurrentPage == TotalPage) { //O trang cuoi cung
                
                //Khong the tien toi trang sau
                ChangButtonState(NextPageButton, false)
                ChangButtonState(LastPageButton, false)
                
                //Co the quay ve trang truoc
                ChangButtonState(PrevPageButton, true)
                ChangButtonState(FirstPageButton, true)
                
            }
            else { //O cac trang giua
                
                //Co the quay ve trang truoc
                ChangButtonState(NextPageButton, true)
                ChangButtonState(LastPageButton, true)
                
                //Co the tien toi trang sau
                ChangButtonState(PrevPageButton, true)
                ChangButtonState(FirstPageButton, true)
                
            }
            
        }
        
        //Hien thi trang hien tai tren tong so trang
        CurrentPageLabel.text = "\(CurrentPage) / \(TotalPage)"
        
    }
    
    //Thay doi trang thai cua cac nut phan trang
    func ChangButtonState(_ button: UIButton, _ isActive: Bool) {
        button.isEnabled = isActive
        if (isActive == true) {
            button.layer.borderWidth = 0
            button.tintColor  = UIColor.white
            button.backgroundColor = UIColor.systemGreen
        }
        else {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.tintColor = UIColor.black
            button.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        }
    }
    
}

//
// MARK: - Table View Data Source and Table View Delegate
//
extension ErrorProductsViewController:UITableViewDelegate,UITableViewDataSource{
    
    //Tra ve so hang cua bang trong 1 trang
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Mac dinh moi trang 10 hang
        var productNumberPerPage = MaxProductNumberPerPage
        
        //Xu ly truong hop so hang nho hon 10
        if (CurrentPage * MaxProductNumberPerPage > ErrorProductList.count) {
            
            productNumberPerPage = MaxProductNumberPerPage - (CurrentPage * MaxProductNumberPerPage - ErrorProductList.count)
            
        }
        return productNumberPerPage
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.ErrorProduct_TableViewCell) as! ErrorProductsTableViewCell
        
        let index = (CurrentPage - 1) * MaxProductNumberPerPage + indexPath.row
        
        if (index >= 0 && index < ErrorProductList.count) {
            
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
            
            //Kiem tra hop le
            ValidArray[index] = CheckValidation_NameProduct(nameLabel: cell.NameLabel, errorLabel: cell.NameErrorLabel) &&
            CheckValidation_SKU(nameLabel: cell.SKULabel, errorLabel: cell.SKUErrorLabel)
            
        }
        
        return cell
        
    }
    
    //Chi dinh do cao cho 1 o
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = (CurrentPage - 1)  * MaxProductNumberPerPage + indexPath.row
        SelectedProductIndex = index
        
        ErrorProductsTableView.deselectRow(at: indexPath, animated: true)
        let dest = self.storyboard?.instantiateViewController(identifier: Storyboard.EditProductInfo_StoryboardID) as! EditProductInfo_ViewController
        dest.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        dest.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        //Nap du lieu qua man hinh chinh sua thong tin
        dest.info = ErrorProductList[index]
        dest.delegate = self
        
        self.present(dest, animated: true, completion: nil)
    
    }
}

//
// MARK: - Edit Product Infomation Delegate
//
extension ErrorProductsViewController: EditProductInfoDelegate{
    
    func UpdateInfo(info: ProductInfomation) {
        
        ErrorProductList[SelectedProductIndex] = info
        ErrorProductsTableView.reloadData()
        
    }
    
}
