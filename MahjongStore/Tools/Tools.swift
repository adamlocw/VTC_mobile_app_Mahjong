//
//  Tools.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//

import UIKit

//Tools (web loading of images and automatic height calculation based on the given width).
func getTextHeight(_ text:String, font:UIFont, width:CGFloat)->CGFloat{
    var textSize:CGSize!
    if CGSize(width: width, height: CGFloat(MAXFLOAT)).equalTo(CGSize.zero) {
        textSize = text.size(withAttributes: [NSAttributedString.Key.font:font] )
    } else {
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let stringRect = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: option, attributes: [NSAttributedString.Key.font:font], context: nil)
        textSize = stringRect.size
    }
        if textSize.height <= 20
        {
            textSize.height = 20
        }
    return textSize.height
}


extension UIImageView {
    func loadImageFrom(url: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        let image = UIImage(data: imageData)
                        // Do something with your image.
                        DispatchQueue.main.async() { () -> Void in
                            self.image = image
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }.resume()
    }
}
