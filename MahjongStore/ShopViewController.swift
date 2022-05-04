//
//  ShopViewController.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/4/23.
//

import UIKit
import CoreLocation

class ShopViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
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
        
        loadData()
        
    }
    
    // MARK: loadData
    func loadData(){
        
        HubView.shared.show(self.view)
        let param =  ["dataSource":"Cluster0","database":"mobile_app","collection":"mahjongShops"]
        NetworkTool.post(parm:param, url: "https://data.mongodb-api.com/app/data-bwxzq/endpoint/data/beta/action/findOne") { succeed, result in
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
    
    // MARK: tableView delegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopListTableViewCell", for: indexPath) as! ShopListTableViewCell
        
        cell.opennMapButton.tag = indexPath.row
        cell.opennMapButton.addTarget(self, action: #selector(openMap(button:)), for: .touchUpInside)
        
        cell.itemModel = datasource[indexPath.row]
        
        return cell
    }
    
   @objc func openMap(button:UIButton){
       
       let vc =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
       
       vc.shopModel = datasource[button.tag]
       vc.hidesBottomBarWhenPushed = true
       
       self.navigationController?.pushViewController(vc, animated: true)
       
//        let urlString =  "http://maps.apple.com/?q=\(itemModel["shopName"]!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! )&sll=\(itemModel["lat"]!),\(itemModel["lon"]!)&z=1&t=m"
//        UIApplication.shared.open(URL(string: urlString)!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.datasource.count
    }
    
    
}
