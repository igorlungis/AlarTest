//
//  GradientView.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import Foundation
import UIKit

@IBDesignable
class GradientView: UIView {
  @IBInspectable
  var color1: UIColor = UIColor.clear {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var color2: UIColor = UIColor.clear {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var start:CGPoint = CGPoint(x: 0, y: 0.5) {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var end:CGPoint = CGPoint(x: 1, y: 0.5) {
    didSet {
      updateView()
    }
  }
  
  @IBInspectable
  var locations: [NSNumber]? = nil {
    didSet {
      updateView()
    }
  }
  
  
  override class var layerClass: AnyClass { return CAGradientLayer.self }
  var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
}


private extension GradientView {
  func updateView() {
    gradientLayer.colors = [color1, color2].map{$0.cgColor}
    gradientLayer.startPoint = start
    gradientLayer.endPoint = end
    gradientLayer.locations = locations
  }
}

