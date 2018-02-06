//
//  LocationNode.swift
//  ARWorldNavigation
//
//  Created by GEORGE QUENTIN on 05/02/2018.
//  Copyright © 2018 Huis. All rights reserved.
//

import SceneKit
import ARKit
import CoreLocation
import AppCore

public class LocationNode: SCNNode {
    
    let title: String
    var location: CLLocation
    
    var anchor: ARAnchor? {
        didSet {
            guard let transform = anchor?.transform else { return }
            self.position = transform.position()
        }
    }
    
    public init(title: String, location: CLLocation) {
        self.title = title
        self.location = location
        super.init()
        let billboardConstraint = SCNBillboardConstraint()
        billboardConstraint.freeAxes = SCNBillboardAxis.Y
        constraints = [billboardConstraint]
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.title = ""
        self.location = CLLocation()
        super.init(coder: aDecoder)
    }

    // Basic sphere graphic
    
    func createSphereNode(with radius: CGFloat, color: UIColor) -> SCNNode {
        let geometry = SCNSphere(radius: radius)
        geometry.firstMaterial?.diffuse.contents = color
        let sphereNode = SCNNode(geometry: geometry)
        return sphereNode
    }
    
    // Add graphic as child node - basic 
    
    func addSphere(with radius: CGFloat, and color: UIColor) {
        let sphereNode = createSphereNode(with: radius, color: color)
        addChildNode(sphereNode)
    }
    
    // Add graphic as child node - with text 
    
    func addNode(with radius: CGFloat, and color: UIColor, and text: String) {
        let sphereNode = createSphereNode(with: radius, color: color)
        let newText = SCNText(string: title, extrusionDepth: 0.05)
        newText.font = UIFont (name: FamilyName.avenirNextMedium, size: 1)
        newText.firstMaterial?.diffuse.contents = UIColor.red
        let _textNode = SCNNode(geometry: newText)
        let annotationNode = SCNNode()
        annotationNode.addChildNode(_textNode)
        annotationNode.position = sphereNode.position
        addChildNode(sphereNode)
        addChildNode(annotationNode)
    }

}