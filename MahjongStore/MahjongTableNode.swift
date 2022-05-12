//
//  MahjongTableNode.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/12.
//

import UIKit
import SceneKit

// This is the third page for the AR experience in this mobile application.
class MahjongTableNode: SCNNode {
    
    override init(){
        super.init()
        
        guard let url = Bundle.main.url(forResource: "mahjongTable", withExtension: "scn") else {
            fatalError("baby_groot.dae not exit.")
        }

        guard let customNode = SCNReferenceNode(url: url) else {
            fatalError("load baby_groot error.")
        }
        customNode.load()
        
        let v:Float=0.003
        customNode.scale=SCNVector3Make(v, v, v)
        customNode.name="mahjongTable"
        
        self.addChildNode(customNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
