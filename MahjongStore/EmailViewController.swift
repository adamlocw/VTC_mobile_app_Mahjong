//
//  EmailViewController.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/10.
//

import UIKit

//Class for Email View Controller.
class EmailViewController: UIViewController {
    
    var contentString:String!
    
    @IBOutlet weak var senderName: UITextField!
    @IBOutlet weak var toTextFiled: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextFiled: UITextField!
    @IBOutlet weak var fromTextFiled: UITextField!
    @IBOutlet weak var customerTextFiled: UITextField!
    
    //Load the customer name and email address if the customer ordered before.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userName = UserDefaults.standard.value(forKey: "SenderName") as? String ?? ""
        let customerEmail = UserDefaults.standard.value(forKey: "customerEmailAddress") as? String ?? ""
        
        self.senderName.text = userName
        self.customerTextFiled.text = customerEmail
        
        let customerName = userName.count > 0 ?   "Hello, \(userName)\n\n" : ""
        
        self.contentTextView.text = customerName + contentString + "\n\(customerEmail)"
        customerTextFiled.addTarget(self, action: #selector(changedTextField(textFiled:)), for: .editingChanged)
        senderName.addTarget(self, action: #selector(customerNameChangedTextField(textFiled:)), for: .editingChanged)
    }
    
    @objc func customerNameChangedTextField(textFiled:UITextField){
        
        self.contentTextView.text = "Hello, \(textFiled.text!)\n\n" + contentString + customerTextFiled.text!
        
    }
    
    @objc func changedTextField(textFiled:UITextField){
        
        self.contentTextView.text = "Hello, \(senderName.text!)\n\n" + contentString + "\n\(textFiled.text!)"
        
    }

    //Cancel the order.
    @IBAction func cancelButtonClick(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    //Confirm and send the order email to shop. 
    @IBAction func sendButtonClick(_ sender: Any) {

      
        guard customerTextFiled.text!.count > 0 else{
            
            HubView.shared.show(message: "customer email cannot be empty")
            return
        }
        
        guard senderName.text!.count > 0 else{
            
            HubView.shared.show(message: "SenderName cannot be empty")
            return
        }
        
        guard titleTextFiled.text!.count > 0 else{
            
            HubView.shared.show(message: "subject cannot be empty")
            return
        }
        
        guard contentTextView.text!.count > 0 else{
            
            HubView.shared.show(message: "content cannot be empty")
            return
        }
        
        HubView.shared.show(self.view)
        let dict = ["personalizations":
                        [["to": [["email": toTextFiled.text!]]]],
                         "from":["email": fromTextFiled.text!],
                         "subject":titleTextFiled.text!,
                         "content": [["type":"text/plain", "value": contentTextView.text!]]] as [String : Any]
        
        print("---\(dict)")
        NetworkTool.postEmail(parm: dict, url: "https://api.sendgrid.com/v3/mail/send") { succeed, result in
            HubView.shared.dismiss()
            if (succeed){
                DispatchQueue.main.async{ [self] in
                    
                    self.dismiss(animated: true)
                    HubView.shared.show(message: "send successed")
                    /// save UserName and email
                    UserDefaults.standard.setValue(senderName.text!, forKey: "SenderName")
                    UserDefaults.standard.setValue(customerTextFiled.text!, forKey: "customerEmailAddress")
                    UserDefaults.standard.synchronize()
                }
            }else{
                
                DispatchQueue.main.async{
                    HubView.shared.show(message: result as! String)
                }
            }
        }

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }

}
