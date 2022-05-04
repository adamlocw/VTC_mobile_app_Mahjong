//
//  EmptyDataView.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/4.
//

import UIKit

//If data load failed, application will show this page to click to reload data
class EmptyDataView: UIView {

    var loadAgainButtonReturn: ((() -> Void)?)
   
     init(frame: CGRect,buttonClick:(() -> Void)?) {
        super.init(frame: frame)
         self.loadAgainButtonReturn = buttonClick
        creatUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI(){
        
        self.backgroundColor = .white
        
        let button = UIButton(frame: CGRect(origin: self.center, size: CGSize(width: 100, height: 40)))
        button.setTitle("Load Again", for: .normal)
        button.titleLabel?.textColor = .lightGray
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(loadAgainButtonClick), for: .touchUpInside)
        self.addSubview(button)
        
    }
    
    @objc func loadAgainButtonClick(){
        
        loadAgainButtonReturn!()
    }

}
