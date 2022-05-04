//
//  OrderListTableViewCell.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//

import UIKit

//The class for the custom tableViewCell on the page of order list
class OrderListTableViewCell: UITableViewCell {

    var productNum:Int = 0
    var  productNumReturn:((Int)->Void)?
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productNumber: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    var itemModel = [String:String](){
        
        didSet{
            productName.text = itemModel["productName"]
            productDescription.text = itemModel["productDescription"]
            productImg.loadImageFrom(url: itemModel["productImage"]!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func changeNumberClick(_ sender: UIButton) {
            if sender.isEqual(self.addButton){
                productNum +=  1
                self.productNumber.text = "\(productNum)"
                self.productNumReturn!(productNum)
            }else{
                productNum -= 1
                if productNum < 0{
                    productNum = 0
                    return
                }
                self.productNumber.text = "\(productNum)"
                self.productNumReturn!(productNum)
              
            }
        print("productNum==\(productNum)")
     
    }



}
