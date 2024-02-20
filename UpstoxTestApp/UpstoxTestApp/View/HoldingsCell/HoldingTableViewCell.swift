//
//  HoldingTableViewCell.swift
//  UpstoxTestApp
//
//  Created by Harsh Raj on 19/02/24.
//

import Foundation
import UIKit

class HoldingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pAndl: UILabel!
    @IBOutlet weak var ltp: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var symbol: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ userHolding: UserHolding) {
        
        let symbolattributedString = NSAttributedString(string: userHolding.symbol, attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 17) ])
        self.symbol.attributedText = symbolattributedString
        
        
        let qtybolattributedString = NSAttributedString(string: "\(userHolding.quantity)", attributes: [
                    .font: UIFont.systemFont(ofSize: 17)])
        self.quantity.attributedText = qtybolattributedString

        let ltpText = NSMutableAttributedString(string: "LTP: ₹ ", attributes: Utility.keyAttributes)
        let ltpValue = NSMutableAttributedString(string:"\(userHolding.ltp)", attributes: Utility.valueAttributes)
        ltpText.append(ltpValue)
        self.ltp.attributedText = ltpText
        
        let pLText = NSMutableAttributedString(string: "P/L: ₹ ", attributes: Utility.keyAttributes)
        let pLValue = NSMutableAttributedString(string: "\(Double(round(100 * userHolding.getProfitLoss())/100))", attributes: Utility.valueAttributes)
        pLText.append(pLValue)
        self.pAndl.attributedText = pLText
                                                                                 

    }

}
