//
//  OrderViewController.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/6.
//

import UIKit
import Foundation
import MessageUI
import LocalAuthentication

// The second page of order items.
class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    
    var datasource = [[String:String]]()
    var emptyDataView:EmptyDataView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.value(forKey: "SenderName") as? String
        self.navigationItem.title =  "Hello, \(userName ?? "Customer")!"
        
        emptyDataView = EmptyDataView(frame: self.view.bounds, buttonClick: {
            
            self.loadData()
        })
        emptyDataView.isHidden = true
        self.view.addSubview(emptyDataView)
        tableView.rowHeight = 130
        
        loadData()
    }
    
    //Getting the detailed order list from MongoDB with data API service.
    func loadData(){
        
        HubView.shared.show(self.view)
        NetworkTool.post(parm: ["dataSource":"Cluster0","database":"mobile_app","collection":"shopItems"], url: "https://data.mongodb-api.com/app/data-bwxzq/endpoint/data/beta/action/findOne") { succeed, result in
            HubView.shared.dismiss()
            //
            if (succeed){
                
                self.datasource = result as! [[String : String]]
                DispatchQueue.main.async{
                    self.emptyDataView.isHidden = true
                    self.tableView.reloadData()
                }
                
            }else{
                DispatchQueue.main.async{
                    self.emptyDataView.isHidden = false
                    HubView.shared.show(message: result as! String)
                }
               
            }
        }
    }
    
    //Create the table view and cell for the order list items.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListTableViewCell", for: indexPath) as! OrderListTableViewCell
        
        cell.itemModel = datasource[indexPath.row]
        cell.productNumReturn = { (productNumber) in
            
            self.datasource[indexPath.row]["productNumber"] = "\(productNumber)"
        }
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datasource.count
    }
    
    //Button for order items confirmation and send the confirmation email to shop, need Face ID before send the order confirmation email.
    @IBAction func confirmButtonClick(_ sender: Any) {
        
        var totalNumber:Int = 0
        var contentString = ""
        datasource.forEach { dict in
            
            let productNumber:Int = Int(dict["productNumber"]!)!
            
            if productNumber > 0  {
                
                contentString += "\(dict["productName"]!) x \(productNumber)\n"
                totalNumber += productNumber
            }
        }
        
        guard totalNumber > 0 else{
            
            HubView.shared.show(message: "please input productNumber")
            return
        }
        
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Face ID") { (isSuccess, isError) in
            if isSuccess {
                
                DispatchQueue.main.async{
                    
                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
                    vc.contentString = contentString
                    self.present(vc, animated: true)
                }
                
            }else{
                
                DispatchQueue.main.async{
                    
                    HubView.shared.show(message: "Face ID Not Working")
                }
            }
        }
    }
    
}
