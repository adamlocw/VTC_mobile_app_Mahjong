//
//  ARViewController.swift
//  MahjongStore
//
//  Created by Adam LO on 2022/5/13.
//

import UIKit
import SceneKit
import ARKit

//Class of AR View Controller
class ARViewController: UIViewController,ARSCNViewDelegate {

    //Load the MahjongTableNode
    @IBOutlet var sceneView: ARSCNView!
     var customNode =  MahjongTableNode()
    
    var session: ARSession {
        return sceneView.session
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.horizontal]
        session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sceneView.showsStatistics = true
        
        let userName = UserDefaults.standard.value(forKey: "SenderName") as? String
        self.navigationItem.title =  "Hello, \(userName ?? "Customer")!"

    }
    
    //AR SCN view delegate
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor  else { return }
        print("-----------------------> session did add anchor!")
        node.addChildNode(customNode)
        
        
    }


}
