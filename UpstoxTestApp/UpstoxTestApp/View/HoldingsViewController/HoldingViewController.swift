//
//  ViewController.swift
//  UpstoxTestApp
//
//  Created by Harsh Raj on 19/02/24.
//

import UIKit

class HoldingViewController: UIViewController {
    
    
    @IBOutlet weak var collapsableButton: UIButton!
    @IBOutlet weak var currentValue: UILabel!
    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var upStoxLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var otherDetailsStackView: UIStackView!
    @IBOutlet weak var totalInvelstmentLabel: UILabel!
    
    @IBOutlet weak var pAndLValue: UILabel!
    @IBOutlet weak var pAndLLabel: UILabel!
    @IBOutlet weak var todayPAndLValue: UILabel!
    @IBOutlet weak var totalInvestmentValue: UILabel!
    @IBOutlet weak var holdingTableView: UITableView!
    @IBOutlet weak var todayPAndLLabel: UILabel!
    
    
    
    let viewModel = HoldingViewModel()
    
    var holdingModel: [UserHolding] = []
    
    var isExpanded: Bool = true {
        didSet {
            guard self.collapsableButton != nil else { return }
            UIView.animate(withDuration: 0.25) {
                if self.isExpanded {
                    self.collapsableButton.transform = CGAffineTransform.identity
                } else {
                    self.collapsableButton.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 1.0)
                }
                self.otherDetailsStackView.isHidden = self.isExpanded
            }
        }
    }
    
    @IBAction func expandOtherDetailsView() {
                
        isExpanded = !isExpanded
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        self.viewModel.fetchDataFromApi { [weak self] response in
            guard let self else { return }
            self.holdingModel = response.userHolding
            DispatchQueue.main.async {
                self.holdingTableView.reloadData()
                self.setupOtherData()
            }
        }
    }
    
    private func setupOtherData() {
        self.currentValueLabel.attributedText = NSMutableAttributedString(string: "Current Value:", attributes: Utility.valueAttributes)
        self.currentValue.text = "₹ \(viewModel.getTotalCurrentValue(self.holdingModel))"
        
        self.totalInvelstmentLabel.attributedText = NSMutableAttributedString(string: "Total Investment:", attributes: Utility.valueAttributes)
        self.totalInvestmentValue.text = "₹ \(viewModel.getTotalInvestment(self.holdingModel))"
        
        self.pAndLLabel.attributedText = NSMutableAttributedString(string: "Profit & Loss:", attributes: Utility.valueAttributes)
        self.pAndLValue.text = "₹ \(viewModel.totalProfitAndLoss)"
        
        self.todayPAndLLabel.attributedText = NSMutableAttributedString(string: "Today's Profit & Loss:", attributes: Utility.valueAttributes)
        self.todayPAndLValue.text = "₹ \(viewModel.getTodayProfitAndLoss(self.holdingModel))"
    }
    
    
    private func setupView() {
        self.upStoxLabel.text = "Upstox Holdings"
        self.upStoxLabel.font = UIFont(name: "tondocorp-Bold", size: 17)
//        self.collapsableButton.setImage(UIImage(named: "upwardArrow"), for: .normal)
        self.otherDetailsStackView.isHidden = true
        self.holdingTableView.backgroundColor = UIColor(red: 195/255, green: 195/255, blue: 199/255, alpha: 1.0)
    }


}

extension HoldingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        holdingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoldingTableViewCell", for: indexPath) as! HoldingTableViewCell
        cell.configure(holdingModel[indexPath.row])
        return cell
    }
    
}

