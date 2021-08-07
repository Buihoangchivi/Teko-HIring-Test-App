//
//  ErrorProducts_ViewController.swift
//  Teko Hiring Test App
//
//  Created by Bui Van Vi on 8/7/21.
//  Copyright © 2021 Bui Van Vi. All rights reserved.
//

import UIKit

class ErrorProductsViewController: UIViewController {
    
    //IBOutlet
    @IBOutlet weak var ErrorProductsTableView: UITableView!
    @IBOutlet weak var FirstPageButton: UIButton!
    @IBOutlet weak var PrevPageButton: UIButton!
    @IBOutlet weak var CurrentPageLabel: UILabel!
    @IBOutlet weak var ChangeCurrentPageButton: UIButton!
    @IBOutlet weak var NextPageButton: UIButton!
    @IBOutlet weak var LastPageButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        /*ShadowViewLeftConstraint.constant += view.bounds.width
        ShadowViewRightConstraint.constant -= view.bounds.width*/
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*ShadowViewLeftConstraint.constant -= view.bounds.width
        ShadowViewRightConstraint.constant += view.bounds.width
        UIView.animate(withDuration: 0.7,
                       delay: 1,
                     animations: { [weak self] in
                      self?.view.layoutIfNeeded()
        }, completion: nil)*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Init()
    }

    func Init() {
        
    }
    
}
