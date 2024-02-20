////
////  HoldingViewController.swift
////  UpstoxTestApp
////
////  Created by Harsh Raj on 19/02/24.
////
//
//import Foundation
//import UIKit
//
//class HoldingViewController: UIViewController {
//    
//
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.viewModel.fetchDataFromApi { [weak self] response in
//            guard let self else { return }
//            self.holdingModel = response.userHolding
//            DispatchQueue.main.async {
//                self.holdingTableView.reloadData()
//            }
//        }
//        setupViewForHolding()
//    }
//    
//    func setupViewForHolding() {
//        
//    }
//}
//
//
//extension HoldingViewController: UITableViewDelegate, UITableViewDataSource {
//   
//    
//    
//}
