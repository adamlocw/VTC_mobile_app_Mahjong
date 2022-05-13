//
//  NetworkTool.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/7.
//

import UIKit

class NetworkTool: NSObject {

  //Using post method to get the information from MongoDB with Data API service.
  class  func post(parm:Any,url:String,finish:@escaping (_ succeed:Bool,_ result:Any)->Void) {
        
        let session = URLSession(configuration: .default)
        //URL
        var request = URLRequest(url: URL(string: url)!)
        request.setValue("mongodb-api-key", forHTTPHeaderField: "api-key")
        request.httpMethod = "POST"
      request.timeoutInterval = 20
      request.httpBody = try! JSONSerialization.data(withJSONObject: parm, options: .prettyPrinted)

        let task = session.dataTask(with: request) {(data, response, error) in
            do{
                
                if data != nil{
                    
                    if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments, .mutableContainers , .mutableLeaves]) as? NSDictionary
                    {
                        print("_______\(jsonObj)")
                        let dict:[NSString:Any] = jsonObj["document"] as! [NSString : Any]
                        finish(true,dict["data"]!)

                    }else{
                        finish(false,"data parsing failed")
                    }
                }
            }catch{
                
                finish(false,error.localizedDescription)
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    // Using post method to send the order items confirmation email via SendGrid Web API service.
    class  func postEmail(parm:Any,url:String,finish:@escaping (_ succeed:Bool,_ result:Any)->Void) {
          
          let session = URLSession(configuration: .default)
          //URL
          var request = URLRequest(url: URL(string: url)!)
          request.setValue("Bearer sendgrid-send-email-api-key", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          request.httpMethod = "POST"
        request.httpBody = try! JSONSerialization.data(withJSONObject: parm, options: .prettyPrinted)

          let task = session.dataTask(with: request) {(data, response, error) in
              
              
              do{

                  if data != nil{

                      if let jsonObj:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: [.allowFragments, .mutableContainers , .mutableLeaves]) as? NSDictionary
                      {
                          print("_______\(jsonObj)")
//                          let dict:[NSString:Any] = jsonObj["document"] as! [NSString : Any]
                          finish(false,"send failed!")

                      }else{
                          finish(true,"send success!")
                      }
                  }
              }catch{

                  finish(true,"send success!")
              }
          }
          task.resume()
      }
    
}
