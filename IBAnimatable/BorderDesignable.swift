//
//  Created by Jake Lin on 11/18/15.
//  Copyright © 2015 Jake Lin. All rights reserved.
//

import UIKit

public protocol BorderDesignable {
  /**
    `border-color`, border color, default value is `UIColor.clearColor()`
  */
  var borderColor: UIColor { get set }

  /**
   `border-width`, border width, default value is `0`
   */
  var borderWidth: CGFloat { get set }
  
  /**
   border side: Top, Right, Bottom or Left, if not specified, all border sides will display,
   */
  var borderSide: String { get set }
  
}

public extension BorderDesignable where Self: UIView {
  public func configBorder() {
    if (borderColor == UIColor.clearColor() || borderWidth == 0) {
      return
    }
    
    // if borderSide has been specified, only display one side
    if let side = BorderSide(rawValue: borderSide) {
      let border = CALayer()
      border.backgroundColor = borderColor.CGColor
      
      switch side {
      case .Top:
        border.frame = CGRectMake(0, 0, bounds.size.width, borderWidth)
      case .Right:
        border.frame = CGRectMake(bounds.size.width - borderWidth, 0, borderWidth, bounds.size.height)
      case .Bottom:
        border.frame = CGRectMake(0, bounds.size.height - borderWidth, bounds.size.width, borderWidth)
      case .Left:
        border.frame = CGRectMake(0, 0, borderWidth, bounds.size.height)
      }
      
      self.layer.addSublayer(border)
    }
    else {
      // Otherwise, display all border sides
      layer.borderColor = borderColor.CGColor
      layer.borderWidth = borderWidth
    }
  }
}
