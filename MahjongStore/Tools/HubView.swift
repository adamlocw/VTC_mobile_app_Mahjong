//
//  HubView.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//
//

import Foundation
import UIKit

//Prompt boxes and network latency waiting.
 final class HubView: NSObject {
    static let shared = HubView()
    private override init() {}
   
    let BOUNDS = UIScreen.main.bounds
    let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    
    let quanlable:UILabel = UILabel()
    var activityIndicatorView:UIView = UIView()
    var quanActivityIndicator:UIActivityIndicatorView = UIActivityIndicatorView(style:.large)
    func show(_ currentView:UIView){

        activityIndicatorView.frame = BOUNDS
        quanlable.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        quanlable.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2-quanlable.bounds.size.width)
        quanlable.backgroundColor = UIColor.init(white: 0, alpha: 0.1)
        quanlable.layer.cornerRadius = 8
        quanlable.layer.masksToBounds = true
        activityIndicatorView.addSubview(quanlable)
        
        activityIndicatorView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        quanActivityIndicator.color = UIColor.white
        quanActivityIndicator.center = CGPoint(x: SCREEN_WIDTH/2, y: SCREEN_HEIGHT/2-quanlable.bounds.size.width)
        quanActivityIndicator.startAnimating()
        activityIndicatorView.addSubview(quanActivityIndicator)
        currentView.addSubview(activityIndicatorView)

        
    }
    func dismiss(){
        DispatchQueue.main.async {
            self.activityIndicatorView.removeFromSuperview()
        }
    }
     
      func show(message:String){
         let messageLable:UILabel = UILabel()
         var window = (UIApplication.shared.delegate as! AppDelegate).window
         let windows = UIApplication.shared.windows
         for win in windows{
             let viewName = NSStringFromClass(win.classForCoder)
             if viewName == "UIRemoteKeyboardWindow" {
                 window = win
                 break
             }
         }
         let size = (message as NSString).size(withAttributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17)])
         
         var width:CGFloat = 0
         var height:CGFloat = 0
         if size.width + 20 > SCREEN_WIDTH{
             width = SCREEN_WIDTH - 80
             height = getTextHeight(message, font: UIFont.systemFont(ofSize: 17), width: SCREEN_WIDTH - 80)+10
         }else{
             width = size.width + 20
             height = size.height + 20
         }
         messageLable.bounds = CGRect(x: 0, y: 0, width: width, height: height)
         messageLable.center = CGPoint(x: window!.bounds.size.width / 2, y: window!.bounds.size.height / 2)
         messageLable.text = message
         messageLable.numberOfLines = 0
         messageLable.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
         messageLable.textColor = UIColor.white
         
         
         messageLable.textAlignment = NSTextAlignment.center
         messageLable.layer.cornerRadius = 4
         messageLable.layer.masksToBounds = true
         window?.addSubview(messageLable)
         UIView.animate(withDuration: 1.0, delay: 1.0, options: UIView.AnimationOptions.allowUserInteraction, animations: { () -> Void in
             messageLable.alpha = 0
             }) { (complete) -> Void in
                 messageLable.removeFromSuperview()
         }
     }
}
